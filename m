Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132587AbRBRCM3>; Sat, 17 Feb 2001 21:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132604AbRBRCMT>; Sat, 17 Feb 2001 21:12:19 -0500
Received: from ns2.baymountain.com ([63.102.49.3]:61965 "EHLO
	ns2.baymountain.com") by vger.kernel.org with ESMTP
	id <S132587AbRBRCMK>; Sat, 17 Feb 2001 21:12:10 -0500
Message-ID: <3A8F2F76.8B9FBE15@baymountain.com>
Date: Sat, 17 Feb 2001 21:12:06 -0500
From: Emil Briggs <emil@baymountain.com>
Organization: Bay Mountain, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serverworks HE quad Xeon: strange network lockups
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We just got a SuperMicro S2QE6 which is a quad
Xeon motherboard using the Serverworks HE chipset.
It has onboard ethernet (Intel 82559). After installing
Redhat 6.2 the Ethernet stopped working with the
message "eth0: card reports no resources"

>From what I have seen there is nothing that unusual
with this and the 82559. What is strange is that the
network starts working again if you type something on
the keyboard. This is 100% repeatable -- don't type
on the keyboard and the ethernet freezes up with the no
resources message in a few minutes. Touch the keyboard
and it starts working again immediately.

I'm going to update the kernel and see if that fixes the
issue but it struck me as a rather unusual problem.

Regards
Emil Briggs
