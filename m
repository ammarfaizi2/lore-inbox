Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbTAGR7J>; Tue, 7 Jan 2003 12:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267532AbTAGR7I>; Tue, 7 Jan 2003 12:59:08 -0500
Received: from robur.slu.se ([130.238.98.12]:27916 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S267510AbTAGR7I>;
	Tue, 7 Jan 2003 12:59:08 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15899.6490.732494.523858@robur.slu.se>
Date: Tue, 7 Jan 2003 19:15:54 +0100
To: "Avery Fay" <avery_fay@symantec.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: Gigabit/SMP performance problem
In-Reply-To: <OFAB3BBE62.009CD13E-ON85256CA6.00714931-85256CA6.00718BA3@symantec.com>
References: <OFAB3BBE62.009CD13E-ON85256CA6.00714931-85256CA6.00718BA3@symantec.com>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avery Fay writes:
 > Hmm. That paper is actually very interesting. I'm thinking maybe with the 
 > P4 I'm better off with only 1 cpu. WRT hyperthreading, I actually disabled > it because it make performance worse (wasn't clear in the original email).


 With 1CPU-SMP-HT I'm on UP level of performance this with forwarding two 
 single flows evenly distributes between CPU's. So HT payed the SMP cost so 
 to say.
 
 Also I tested the MB bandwidth with new threaded version of pktgen just 
 TX'ing a packets on 6 GIGE I'm seeing almost 6 Gbit/s TX'ed w 1500 bytes
 packets.

 I have problem populating all slots w. GIGE NIC's. WoL (Wake on Lan) this
 is a real pain... Seems like my adapters needs a standby current 0.8A and 
 most Power Supplies gives 2.0A for this. (Number come from SuperMicro). 
 So booting fails radomlingy. You have 8 NIC's -- Didn't you have problem?

 Anyway I'll guess profiling is needed?

 Cheers.
						--ro
