Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbUJaLsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbUJaLsp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUJaLri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:47:38 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:42937 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261580AbUJaLgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 06:36:01 -0500
Date: Sun, 31 Oct 2004 12:35:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: lxdialog question
In-Reply-To: <Pine.LNX.4.53.0410301255220.2322@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.53.0410311230060.30732@yvahk01.tjqt.qr>
References: <Pine.LNX.4.53.0410292119540.23650@yvahk01.tjqt.qr>
 <20041030081816.GA9645@mars.ravnborg.org> <Pine.LNX.4.53.0410301255220.2322@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JE> I wanted to patch lxdialog with the upstream code so that it supports UTF-8
JE> i/o and utf-8-consoles, but I would need to know from which 'dialog' it
JE> forked in the past.

SR>The only indication I could find was this note in scripts/README.Menuconfig:
[...]

JE>It looks like it's based on dialog-0.7 since it creates the smallest diff.
[...]

lxdialog already seems to support UTF-8 (read: ncurses supports it), since it
actually works when TERM=xterm or =screen. However, not so with =linux or
=screen.linux.


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
