Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270070AbUJHR1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270070AbUJHR1A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270067AbUJHR07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:26:59 -0400
Received: from open.hands.com ([195.224.53.39]:29907 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S270071AbUJHR0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:26:47 -0400
Date: Fri, 8 Oct 2004 18:37:50 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Brice.Goglin@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Message-ID: <20041008173750.GP5551@lkcl.net>
References: <20041008130442.GE5551@lkcl.net> <41669DE0.9050005@didntduck.org> <20041008151837.GI5551@lkcl.net> <4166AFD0.2020905@ens-lyon.fr> <20041008162025.GL5551@lkcl.net> <20041008163701.GV5033@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008163701.GV5033@lug-owl.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 06:37:01PM +0200, Jan-Benedict Glaw wrote:
> On Fri, 2004-10-08 17:20:25 +0100, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
> wrote in message <20041008162025.GL5551@lkcl.net>:
> > On Fri, Oct 08, 2004 at 05:18:40PM +0200, Brice Goglin wrote:
> 
> > > mm_segment_t old_fs;
> > > old_fs = get_fs();
> > > set_fs(KERNEL_DS);
> > > <do you stuff here>
> > > set_fs(old_fs);
> >  
> >  that's it!  that's what i was looking for.  thank you.
> 
> Most probably, this is not what you were looking for. You just don't
> know that yet (-:
 
 *grin*.  yeh, like someone else privately responded saying i might want
 to look at compat_alloc_userspace() instead :)


