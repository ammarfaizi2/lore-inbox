Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278040AbRJIWtP>; Tue, 9 Oct 2001 18:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278042AbRJIWtF>; Tue, 9 Oct 2001 18:49:05 -0400
Received: from hermes.toad.net ([162.33.130.251]:19400 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S278040AbRJIWsy>;
	Tue, 9 Oct 2001 18:48:54 -0400
Subject: Re: sysctl interface to bootflags?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: davej@suse.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 09 Oct 2001 18:48:56 -0400
Message-Id: <1002667739.763.9.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.  I tested the new sbf.c and after hacking it a
bit to remove the fail-on-invalid-reg-value, it runs:

root@thanatos:/home/jdthood/src/sbf# ./a.out
BOOT @ 0x07fd0040
CMOS register: 0x33
Read current value := 0x88
Read updated value := 0x89

Here it has set bit 0, the PnP-OS bit.  Do you have any
plans to enhance the program to allow control of all the flags?

--
Thomas

