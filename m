Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263987AbRFMPNo>; Wed, 13 Jun 2001 11:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263993AbRFMPNe>; Wed, 13 Jun 2001 11:13:34 -0400
Received: from c017-h020.c017.sfo.cp.net ([209.228.12.234]:5813 "HELO
	c017.sfo.cp.net") by vger.kernel.org with SMTP id <S263987AbRFMPNX>;
	Wed, 13 Jun 2001 11:13:23 -0400
X-Sent: 13 Jun 2001 15:13:13 GMT
Message-ID: <3B276DDE.A19F60DF@sangate.com>
Date: Wed, 13 Jun 2001 16:42:54 +0300
From: Mark Mokryn <mark@sangate.com>
Organization: SANgate Systems
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMP module compilation on UP?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it possible to build an SMP module on a machine running a UP kernel
(or vice versa)? We of course get unresolved symbols during module load
due to the smp prefix on the ksyms, and haven't seen how to get around
it. (Defining __SMP__ does not cut it, though I believe this used to
work a while ago).

Please reply to me as well as to the list.

Thanks,
-mark
