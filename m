Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSEVJ3E>; Wed, 22 May 2002 05:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316904AbSEVJ3D>; Wed, 22 May 2002 05:29:03 -0400
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:41403 "EHLO pluvier")
	by vger.kernel.org with ESMTP id <S315491AbSEVJ3C>;
	Wed, 22 May 2002 05:29:02 -0400
Date: Wed, 22 May 2002 11:31:40 +0200
From: Eric Lemoine <Eric.Lemoine@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Subject: i8259 and IO-APIC
Message-ID: <20020522093139.GA390@hookipa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: return path set from From: address
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I already asked this question but did not get any responses. Please
condider answering.

Using the old i8259 interrupts controller, my 1-way Linux2.4.16 box
livelocks when receiving a high rate UDP flow (interrupt rate is so
high that the NET_RX_SOFTIRQ never gets the chance to pull the
packets off the backlog queue). However, the receive livelock
phenomenom completely disappears when making use of the IO-APIC.
Does anyone have an explanation for this?

TIA
-- 
Eric
