Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTILSmy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbTILSlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:41:31 -0400
Received: from angband.namesys.com ([212.16.7.85]:22401 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261839AbTILSkD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:40:03 -0400
Date: Fri, 12 Sep 2003 22:40:01 +0400
From: Oleg Drokin <green@namesys.com>
To: Kyle Rose <krose+linux-kernel@krose.org>, linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
Message-ID: <20030912184001.GA9245@namesys.com>
References: <87r82noyr9.fsf@nausicaa.krose.org> <20030912153935.GA2693@namesys.com> <20030912175917.GB30584@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912175917.GB30584@matchmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Sep 12, 2003 at 10:59:17AM -0700, Mike Fedyk wrote:
> > > However, just as the write completed, the beginning of the file became
> > > corrupted.  I considered a 4GB problem to be likely, and re-tested
> > You are absolutely right.
> > Ther is a reiserfs problem that I just found based on your description.
> > The patch below should help. Please confirm that it works for you too.
> > Thanks a lot for the report.
> Yow, I guess large files on reiserfs in 2.6 isn't very common...

Or may be nobody noticed the corruption.

Bye,
    Oleg
