Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWCIWF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWCIWF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWCIWF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:05:27 -0500
Received: from main.gmane.org ([80.91.229.2]:28072 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751760AbWCIWF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:05:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: multimedia keys on dell inspiron 8200s.
Date: Thu, 9 Mar 2006 23:03:02 +0100
Message-ID: <171jjrcj2780l.1nazr87kzdc51$.dlg@40tude.net>
References: <20060224014947.GA17397@redhat.com> <200602242257.54062.dtor_core@ameritech.net> <20060225042729.GB7851@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-48-150.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006 23:27:29 -0500, Dave Jones wrote:

> On Fri, Feb 24, 2006 at 10:57:53PM -0500, Dmitry Torokhov wrote:
>  > On Thursday 23 February 2006 20:49, Dave Jones wrote:
>  > > We've been carrying this patch in Fedora for way too long.
>  > > So long, I've forgotten a lot of the history.
>  > > 
>  > > Aparently, it makes multimedia buttons on Dell Inspiron 8200's
>  > > produce keycodes.  The only reference to this I found was
>  > > at http://linux.siprell.com/, but I don't know if that's its origin.
>  > > 
>  > 
>  > Dave,
>  > 
>  > This patch was refused before. Any additional/non-standard mapping is
>  > to be done in userspace (you need to properly adjust xorg.conf anyway):
>  > 
>  > http://bugzilla.kernel.org/show_bug.cgi?id=2817#c4
> 
> Ok, thanks, I'll make sure it gets dropped from the Fedora tree.

The patch looks remarkably like the one I originally submitted for
comments.

I'm still running Linux on my Dell Inspiron 8200 and I'm not using
that patch anymore. Rather, I found a package that recently made it to
the Debian unstable repository, hotkey-setup

http://packages.debian.org/unstable/misc/hotkey-setup

which you may want to consider for inclusion on Fedora too. On the
Debian BTS you will also see a Bug/Wish from me

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=355223

with additional definitions for the multimedia keys on my Dell and
some comments.

(Sorry for the delay in my reply)


-- 
Giuseppe "Oblomov" Bilotta

[W]hat country can preserve its liberties, if its rulers are not
warned from time to time that [the] people preserve the spirit of
resistance? Let them take arms...The tree of liberty must be
refreshed from time to time, with the blood of patriots and
tyrants.
	-- Thomas Jefferson, letter to Col. William S. Smith, 1787

