Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270776AbTG0Nrs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 09:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270796AbTG0Nrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 09:47:47 -0400
Received: from hera.cwi.nl ([192.16.191.8]:35266 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270776AbTG0Nq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 09:46:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 27 Jul 2003 16:02:09 +0200 (MEST)
Message-Id: <UTC200307271402.h6RE29E24642.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, gtoumi@laposte.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 on alpha : disk label numbering trouble
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I'm trying to run 2.6.0-test1 on an alpha box, 
    and  apparently, the osf partition numbering is wrong:

    On this disk, I have c, d and e disklabels,
    which are seen by 2.2 and 2.4 as /dev/sda[345].
    But 2.6.0-test1 number the slides starting at 1...
    so in 2.2/2.4 my root  is sda5 and in 2.6, sda3. ouch.

    Is this an expected behaviour ?

Can you give some information? Output of fdisk -l and
dmesg | grep sda for 2.4 and 2.6?
