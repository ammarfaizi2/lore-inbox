Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131565AbRCQGaa>; Sat, 17 Mar 2001 01:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131574AbRCQGaU>; Sat, 17 Mar 2001 01:30:20 -0500
Received: from mail.cis.nctu.edu.tw ([140.113.23.5]:11535 "EHLO
	mail.cis.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S131565AbRCQGaL>; Sat, 17 Mar 2001 01:30:11 -0500
Message-ID: <003301c0aeac$517b31d0$ae58718c@cis.nctu.edu.tw>
Reply-To: "gis88530" <gis88530@cis.nctu.edu.tw>
From: "gis88530" <gis88530@cis.nctu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Subject: measurement
Date: Sat, 17 Mar 2001 14:34:27 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I use PSCHED_GET_TIME(stamp) to measure the
delay of some kernel function.

function_name( ) {
int psched_clock_scale;
psched_time_t stamp1, stamp2;
psched_tdiff_t delay;

PSCHED_GET_TIME(stamp1);
PSCHED_GET_TIME(stamp2);
delay=PSCHED_TDIFF(stamp2, stamp1);
printk(KERN_INFO "[%ld], [%ld], [%ld]\n", stamp1, stamp2, delay);
}

But the result like this [135967], [0], [135967].
I really don't know why stamp2 is 0, and
I can't find out the scale of stamp1/stamp2.
(micro-second ?? )

Thanks.
Cheers,
Steven


