Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbTF3Di5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 23:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbTF3Di5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 23:38:57 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:26327 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265632AbTF3DiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 23:38:15 -0400
Message-Id: <200306300352.h5U3qJ12003920@eeyore.valparaiso.cl>
To: rmoser <mlmoser@comcast.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas 
In-Reply-To: Your message of "Sun, 29 Jun 2003 15:48:06 -0400."
             <200306291548060930.02159FEE@smtp.comcast.net> 
X-Mailer: MH-E 7.1; nmh 1.0.4; XEmacs 21.4
Date: Sun, 29 Jun 2003 23:52:18 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmoser <mlmoser@comcast.net> said:
> "Leonard Milcin Jr." <thervoy@post.pl> said:

> >Ok, I forgot about enterprise users with lots of data, and probably
> >lacking free space, so I missed a point.

> Yeppers.  Also that the eventual goal (at least in  my mind) is to allow
> this to be done on a running r/w filesystem safely, which isn't as tough
> a problem as it sounds.

It is a lot of in-kernel complexity, for a one-shot job once in a blue moon
(or even once per machine, if that much). If it can be done easily (like
ext2 --> ext3), by all means go ahead! If there is the slightest hint of
complexity, forget it. Not worth the kernel code, plus it won't ever be
debugged past "nice toy" stage for people who really care about their data.

"Enterprise users" have backups, and are more than willing to just get a
new disk/machine for migrating data. Data is normally _much_ more valuable
than the media it sits on.

Can we now please drop this sillyness? Either show the astonished world
by coding it up and debugging it that it _is_ doable, or shut up.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
