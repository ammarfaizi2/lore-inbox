Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbTILR7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTILR7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:59:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:775
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261778AbTILR7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:59:12 -0400
Date: Fri, 12 Sep 2003 10:59:17 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Oleg Drokin <green@namesys.com>
Cc: Kyle Rose <krose+linux-kernel@krose.org>, linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
Message-ID: <20030912175917.GB30584@matchmail.com>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Kyle Rose <krose+linux-kernel@krose.org>,
	linux-kernel@vger.kernel.org
References: <87r82noyr9.fsf@nausicaa.krose.org> <20030912153935.GA2693@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912153935.GA2693@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 07:39:35PM +0400, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Sep 11, 2003 at 04:28:58PM -0400, Kyle Rose wrote:
> 
> > However, just as the write completed, the beginning of the file became
> > corrupted.  I considered a 4GB problem to be likely, and re-tested
> 
> You are absolutely right.
> Ther is a reiserfs problem that I just found based on your description.
> The patch below should help. Please confirm that it works for you too.
> Thanks a lot for the report.
> 

Yow, I guess large files on reiserfs in 2.6 isn't very common...
