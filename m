Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131439AbQKJUK0>; Fri, 10 Nov 2000 15:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131658AbQKJUKQ>; Fri, 10 Nov 2000 15:10:16 -0500
Received: from mail-04-real.cdsnet.net ([63.163.68.109]:34827 "HELO
	mail-04-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S131657AbQKJUKF>; Fri, 10 Nov 2000 15:10:05 -0500
Message-ID: <3A0C56D4.99E4F5D@mvista.com>
Date: Fri, 10 Nov 2000 12:13:08 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Aloni <karrde@callisto.yi.org>
CC: Ivan Passos <lists@cyclades.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Patch generation
In-Reply-To: <Pine.LNX.4.21.0011102139170.21416-100000@callisto.yi.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> 
> On Fri, 10 Nov 2000, George Anzinger wrote:
> 
> > > 4 kernel trees, one after make dep ; make bzImage, and all taking together
> > > just 193MB, instead of about 400MB... hard links, gotta love'em.
> >
> > Ok, this is cool, but suppose I have the same file linked to all these
> > and want to change it in all the trees, i.e. still have one file.  Is
> > there an editor that doesn't unlink.  Or maybe cp of the edited file??
> > How would you do this?  (I prefer EMACS, which likes to unlink.)
> 
> I know mcedit doesn't unlink (but mcedit kinda sucks), I think nedit
> doesn't unlink too.
> 
> I prefer an editor that unlinks, since in most cases I don't want to
> modify the source trees that I'm not working on, so diff can do what it's
> supposed to do later.

Oh, I agree, but I am working on several things at once so my
development trees are cascaded, usually with a kgdb patch in all of
them.  If I make a change to kgdb, for example, it would be nice to only
have to change it once, so occasionally, I want to do it differently.

George
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
