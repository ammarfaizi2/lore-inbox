Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbULPT0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbULPT0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbULPT0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:26:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49602 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262010AbULPTWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:22:50 -0500
Date: Thu, 16 Dec 2004 14:30:44 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Steve French <smfrench@austin.rr.com>, cliff white <cliffw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: cifs large write performance improvements to Samba
Message-ID: <20041216163044.GG9986@logos.cnet>
References: <41BDC9CD.60504@austin.rr.com> <20041213092057.5bf773fb.cliffw@osdl.org> <41BDE0B4.6020003@austin.rr.com> <41BDE2CF.9060402@austin.rr.com> <20041216121151.GH8246@logos.cnet> <41C1DABF.2050004@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C1DABF.2050004@namesys.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 10:58:07AM -0800, Hans Reiser wrote:
> Marcelo Tosatti wrote:
> 
> >
> >>I have not seen anyone 
> >>doing that on Linux in an automated fashion (e.g running iozone 
> >>automated every time a new 2.6.x.rc on a half a dozen of the fs - simply 
> >>to verify that things had not gotten drastically worse on a particular 
> >>fs due to a bug or sideffect of a global VFS change).
> >>   
> >>
> >
> >Yes, we definately need that.
> >
> > 
> >
> Andrew Morton is saying that iozone does things real apps don't do, that 
> is, it dirties mmap'd pages enough to swamp the machine.
> 
> Do you guys agree or disagree with that?
> 
> Reiser4 needs iozone optimization work which we haven't bothered with yet.

I'm not really familiar with iozone's behaviour, sorry. 

Steve, Andrew?

PS: Yep, another important part (to me at least) of all this automated performance 
testing effort is a detailed understanding of the tests being performed.
