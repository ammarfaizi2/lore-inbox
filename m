Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTLRGC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 01:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTLRGC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 01:02:59 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:61831 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264437AbTLRGC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 01:02:58 -0500
Date: Thu, 18 Dec 2003 01:00:53 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 keyboard not working
Message-ID: <20031218060053.GA645@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Halfway between having uncompressed the kernel and starting init, the console
starts to scroll "atkbd.c: Unknown key pressed", mentioning key code 0 (IIRC),
even though no keys are pressed at all.  After a while, the scrolling stops,
but the keyboard still doesn't work.  2.4 works fine on the same hardware.

Hardware is an Intel SE7505VB2 board with dual 2.40GHz Xeon processors,
and a Logitech PS/2 "Internet keyboard."

Ideas?


thanks,
Lennert
