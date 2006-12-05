Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937410AbWLEJ2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937410AbWLEJ2V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 04:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937414AbWLEJ2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 04:28:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52066 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937410AbWLEJ2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 04:28:20 -0500
Message-ID: <45753BB1.6030102@festi.info>
Date: Tue, 05 Dec 2006 10:28:17 +0100
From: Florian Festi <florian@festi.info>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Meaning of keycodes unclear
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking for the meaning of the following key codes as #defined in 
include/linux/input.h. I need to know what hardware produces the keycode 
and what happens/should happen when the corresponding key is pressed.

KEY_AB
KEY_ANGLE
KEY_ARCHIVE
KEY_CONNECT
KEY_DIGITS
KEY_MACRO
KEY_ISO
KEY_LIST
KEY_POWER2
KEY_QUESTION
KEY_TEEN      # 1- ???
KEY_TWEN      # 2- ???
KEY_RED, KEY_GREEN, KEY_YELLOW, KEY_BLUE  # Video text navigation?

I am currently trying to make all special keys just work by fixing the 
whole keyboard/input stack from the kernel up to the desktop 
environments. On part of this effort is to complete the mappings applied 
to the keys during their way up.

TIA

	Florian Festi
