Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284785AbRLPU0M>; Sun, 16 Dec 2001 15:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284788AbRLPU0C>; Sun, 16 Dec 2001 15:26:02 -0500
Received: from net128-007.mclink.it ([195.110.128.7]:14803 "EHLO
	mail.mclink.it") by vger.kernel.org with ESMTP id <S284785AbRLPUZw>;
	Sun, 16 Dec 2001 15:25:52 -0500
Message-ID: <3C1D0350.9060300@arpacoop.it>
Date: Sun, 16 Dec 2001 21:25:52 +0100
From: Carl Scarfoglio <scarfoglio@arpacoop.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AIC7850 panic (post 2.4.14)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the exact same problem with this chipset (Adaptec 2904), but I 
increased the "Initial bus reset delay" from 150 ms to 250 and solved it.
By the way, do you have cdrom's attached to your scsi card? Beware, 
since 2.5.1-pre8 (at least) the PC will hang solid if I try to mount a 
data cd. Up to 2.5.1-pre11 the problem remains. Can you verify this 
(without mounting any disk, of course)?
Regards,
			Carlo Scarfoglio

