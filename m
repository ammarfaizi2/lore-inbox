Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130178AbRBZGwA>; Mon, 26 Feb 2001 01:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130181AbRBZGvw>; Mon, 26 Feb 2001 01:51:52 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:14610 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S130178AbRBZGvk>; Mon, 26 Feb 2001 01:51:40 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 26 Feb 2001 07:51:22 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.2.18: static rtc_lock in nvram.c
Message-ID: <3A9A0AF9.17727.45317@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

browsing the sources for some problem I wondered why nvram.c uses a 
static spinlock named rtc_lock, hiding the global one.

Regards,
Ulrich

