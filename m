Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbUJaQSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUJaQSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 11:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbUJaQSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 11:18:34 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35791 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261242AbUJaQSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 11:18:33 -0500
Date: Sun, 31 Oct 2004 17:18:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org, pluto@pld-linux.org
Subject: Re: unit-at-a-time...
In-Reply-To: <200410311541.i9VFf0ah023857@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.53.0410311717250.20529@yvahk01.tjqt.qr>
References: <200410311541.i9VFf0ah023857@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>/i386/Makefile:# Disable unit-at-a-time mode, it makes gcc use a lot morestack
>>/i386/Makefile:CFLAGS += $(call cc-option,-fno-unit-at-a-time)

Once I wanted to find out why -finline-functions still did not inline my
funcitons I tagged as "inline".. so I went flag by flag and finally came to the
point where -funit-at-a-time did the actual inlining. So it's like "make my .o
files bigger".

For x86_32 at least.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
