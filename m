Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbTJOK0C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTJOK0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:26:02 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:23291 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S262539AbTJOK0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:26:00 -0400
Message-ID: <00e901c39306$a632a690$3eee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Andries Brouwer" <aebr@win.tue.nl>
Cc: "Andries Brouwer" <aebr@win.tue.nl>, "Vojtech Pavlik" <vojtech@suse.cz>,
       <linux-kernel@vger.kernel.org>, "John Bradford" <john@grabjohn.com>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030921110125.GB18677@ucw.cz> <0a5f01c38043$f9c35c80$44ee4ca5@DIAMONDLX60> <20030921171632.A11359@pclin040.win.tue.nl> <0c2001c38104$34c2a690$44ee4ca5@DIAMONDLX60> <20030922221453.A1064@pclin040.win.tue.nl> <145601c381c8$07956760$44ee4ca5@DIAMONDLX60> <20030923192206.A1504@pclin040.win.tue.nl>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards
Date: Wed, 15 Oct 2003 19:22:05 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer replied to me on 2003.09.24:

> > In order to be capable of loading a working keymap, defkeymap.c_shipped
> > needs patching.
>
> No.

You are right, at least for a PS/2 keyboard.  I finally managed to get
kbd-1.08 built and installed in a manner consistent with Red Hat 7.3 and
kernel 2.6.0-test7, AND had to make a bit more than the obvious edit to the
jp106 keymap file, and got it working for a jp106 PS/2 keyboard.  You are
right that it can be done without modifying defkeymap.c_shipped.  (I haven't
tried it with USB yet.)

