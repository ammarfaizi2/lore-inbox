Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265660AbUFOOdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUFOOdl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUFOOdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:33:41 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:47488 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265660AbUFOOdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:33:39 -0400
Date: Tue, 15 Jun 2004 14:33:39 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Cc: Lubomir Prech <Lubomir.Prech@mff.cuni.cz>
Subject: omnibook xe4500 keyboard works where shouldn't
Message-ID: <20040615143339.A6328@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Somehow I managed to determine a linux kernel configuration where at least the
keyboard works upon startup:

USB HID is off at all
Input core kbd is off
Input core mouse is on.
USB is on.

The question is: How is it possible the keyboard works when it is
switched off on two (=all possible) places at the same time?

So, if it's a PS/2 keyboard, it's swiched off by input core.
If it's a USB keyboard it's switched off by USB HID.

Cl<
