Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbUKJUoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbUKJUoQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUKJUmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:42:02 -0500
Received: from adsl-96-231.38-151.net24.it ([151.38.231.96]:14862 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S262121AbUKJUlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:41:04 -0500
Date: Wed, 10 Nov 2004 21:40:54 +0100
From: Daniele Venzano <webvenza@libero.it>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] WOL for sis900
Message-ID: <20041110204054.GA29083@picchio.gall.it>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4183B6B0.7010906@gmx.de> <1100055532.25963.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1100055532.25963.58.camel@localhost.localdomain>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.27-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 01:58:52PM +1100, Rusty Russell wrote:
> On Sat, 2004-10-30 at 17:43 +0200, Malte Schröder wrote:
> > Hello,
> > I have applied the patch from http://lkml.org/lkml/2003/7/16/88 manually 
> > to 2.6.7 (also works on 2.6.{8,9}) and have been using it since then.
> > Attached is a diff against 2.6.9.
> 
> Want to change the MODULE_PARM to new-style module_param() calls, too?

Just added to the TODO list ;-)
I'm acting as maintainer for the sis900 driver and the list of the TODO
os growing at an awesome speed.

What I'm really lacking is some piece of technical documentation for the
chip. The WoL support depends on this, because I don't know how to check
for the hardware support for it.
For now I'll make available my patch on the sis900 page[1] that uses
ethtool and seems to work.

[1] http://teg.homeunix.org/sis900.html

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

