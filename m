Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289387AbSAVVzm>; Tue, 22 Jan 2002 16:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289405AbSAVVzb>; Tue, 22 Jan 2002 16:55:31 -0500
Received: from fmr01.intel.com ([192.55.52.18]:42220 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S289387AbSAVVzV>;
	Tue, 22 Jan 2002 16:55:21 -0500
Message-ID: <FD2423AA68A7D511A5A20002A50729E13B9F7E@orsmsx115.jf.intel.com>
From: "Abbas, Mohamed" <mohamed.abbas@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: smp_send_stop
Date: Tue, 22 Jan 2002 13:55:11 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using two kernel monte to allow booting new kernal from running kernel.
It work with no problem on non SMP system. To make it work on SMP system I
call smp_send_stop before using KMonte this will make SMP like a single
process machine so two KMonte will work. This solved the problem of letting
two KMonte boot  but when the machine start up the local APIC was still
disabled and interupts are disable. My question How can i reverse the effect
of callig smp_send_stop which call disable_Local_APIC.
Thanks
Mohamed

