Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSEQHHK>; Fri, 17 May 2002 03:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315447AbSEQHHJ>; Fri, 17 May 2002 03:07:09 -0400
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:3245 "EHLO pluvier")
	by vger.kernel.org with ESMTP id <S315445AbSEQHHI>;
	Fri, 17 May 2002 03:07:08 -0400
Date: Fri, 17 May 2002 09:09:36 +0200
From: Eric Lemoine <Eric.Lemoine@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Subject: interrupt controler question
Message-ID: <20020517070936.GA436@hookipa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: return path set from From: address
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the old i8259 interrupts controller, my 1-way Linux2.4.16 box 
livelocks when receiving a high rate UDP flow (interrupt rate is so 
high that the NET_RX_SOFTIRQ never gets the chance to pull the 
packets off the backlog queue). However, the receive livelock 
phenomenom completely disappears when making use of the IO-APIC. 

Anyone has an explanation for this?

THX.
-- 
Eric
