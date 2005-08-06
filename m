Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbVHFDkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbVHFDkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 23:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbVHFDkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 23:40:17 -0400
Received: from mail.tor.primus.ca ([216.254.136.21]:55200 "EHLO
	smtp-05.primus.ca") by vger.kernel.org with ESMTP id S263159AbVHFDkP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 23:40:15 -0400
From: Gabriel Devenyi <ace@staticwave.ca>
To: ck@vds.kolivas.org
Subject: Re: [ck] [ANNOUNCE] Interbench 0.27
Date: Fri, 5 Aug 2005 23:37:54 -0400
User-Agent: KMail/1.8.2
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <200508031758.31246.kernel@kolivas.org> <200508042204.57977.kernel@kolivas.org> <42F207BE.40609@staticwave.ca>
In-Reply-To: <42F207BE.40609@staticwave.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508052337.55270.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After conducting some further research I've determined that cool n quiet has 
no effect on this "bug" if you can call it that. With the system running in 
init 1, and cool n quiet disabled in the bios, a sleep(N>0) results in the 
run_time value afterwards always being nearly the same value of ~995000 on my 
athlon64, similarly, my server an athlon-tbird, which definitely has no power 
saving features, hovers at ~1496000

Obviously since these values are nowhere near 10000, the loops_per_ms 
benchmark runs forever, has anyone seen/read about sleep on amd machines 
doing something odd? Can anyone else with an amd machine confirm this 
behavior? Con: should we attempt to get the attention of LKML to see why amd 
chips act differently?

--
Gabriel Devenyi
ace@staticwave.ca
