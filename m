Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWE3LCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWE3LCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWE3LB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:01:59 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:5552 "EHLO
	pne-smtpout4-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932245AbWE3LBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:01:50 -0400
Message-Id: <20060530105705.157014000@gmail.com>
User-Agent: quilt/0.44-1
Date: Tue, 30 May 2006 13:57:05 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 00/12] input: force feedback updates, third time 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Major update for the force feedback support, including a new force feedback
driver interface and two new HID ff drivers.

This is the patchset I sent in 2006-05-26 with the changes of my latest
patches integrated, as requested.

The changes are:
- make the ff module a bool instead of part of the input module, as we don't
  want to rename input.c
- use the normal event() handler in input_dev so that input.c doesn't have to
  make calls to ff code

-- 
Anssi Hannula
