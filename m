Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTH2TAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTH2TAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:00:53 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:52484
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261763AbTH2TAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:00:47 -0400
Date: Fri, 29 Aug 2003 12:00:48 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mutt segfault with ext3 & 1k blocks & htree in 2.6
Message-ID: <20030829190048.GB3846@matchmail.com>
Mail-Followup-To: Andy Isaacson <adi@hexapodia.org>,
	linux-kernel@vger.kernel.org
References: <20030829172451.GA27023@matchmail.com> <20030829133323.E16285@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829133323.E16285@hexapodia.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 01:33:23PM -0500, Andy Isaacson wrote:
> On Fri, Aug 29, 2003 at 10:24:51AM -0700, Mike Fedyk wrote:
> > I have just converted my 25GB / partition from reiserfs to ext3 with 1k
> > blocks, and now mutt is segfaulting periodocally.
> [snip]
> > I have full strace output of each mutt process up until the segfault in two
> > cases, and up until strace was stopped in the third case.
> 
> The obvious request is "turn on core dumps and get a backtrace".

The problem only shows on 2.6, and it works perfectly on 2.4.  I don't think
it's an app issue.  Also, Debian doesn't compile in the debug symbols, so
the backtrace is not very much use.  (though, I can show the output if you'd
like, just give me another day for it to segfault again.)

Mike
