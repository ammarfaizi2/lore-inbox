Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTI2VHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbTI2VHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:07:23 -0400
Received: from hell.org.pl ([212.244.218.42]:14347 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261178AbTI2VHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:07:22 -0400
Date: Mon, 29 Sep 2003 23:13:44 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PM][INPUT] keyboard dead after resuming from S3
Message-ID: <20030929211344.GC12894@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
As far as I remember, my keyboard (a standard laptop AT keyboard) never
worked after resuming from S3. In older kernels, I was able to get away
with this by reloading atkbd.ko. However, for newer ones (2.6.0-test5-mm4,
specifically), I can't do that, as the following appears:

atkbd: Unknown symbol dump_i8042_history

A similar warning is issued at depmod stage.

How are your plans to add suspend / resume support to the serio core (I
thought I saw some Synaptics patches a while ago)?

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
