Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUGRU6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUGRU6v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 16:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUGRU6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 16:58:51 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:30727 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S264522AbUGRU6u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 16:58:50 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] security/selinux/hooks.c:1898: error: `PER_CLEAR_ON_SETID' undeclared
Date: Sun, 18 Jul 2004 22:58:37 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200407181425.43629.pluto@pld-linux.org> <Pine.LNX.4.58.0407181647590.7127@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.58.0407181647590.7127@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407182258.41581.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 of July 2004 22:51, James Morris wrote:
> On Sun, 18 Jul 2004, [iso-8859-2] Pawe³ Sikora wrote:
> >   CC      security/selinux/hooks.o
> > security/selinux/hooks.c: In function `selinux_bprm_apply_creds':
> > security/selinux/hooks.c:1898: error: `PER_CLEAR_ON_SETID' undeclared
>
> I can't find this symbol anywhere in the kernel.  Is this stock
> 2.6.8-rc2?

# grep PER_CLEAR /usr/src/linux/include/linux/personality.h
#define PER_CLEAR_ON_SETID (READ_IMPLIES_EXEC)

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
