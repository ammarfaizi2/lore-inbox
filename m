Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281007AbRKOTYu>; Thu, 15 Nov 2001 14:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281006AbRKOTYl>; Thu, 15 Nov 2001 14:24:41 -0500
Received: from amdext.amd.com ([139.95.251.1]:63883 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id <S281007AbRKOTYa>;
	Thu, 15 Nov 2001 14:24:30 -0500
From: harish.vasudeva@amd.com
X-Server-Uuid: 02753650-11b0-11d5-bbc5-00508bf987eb
Message-ID: <CB35231B9D59D311B18600508B0EDF2F0197A319@caexmta9.amd.com>
To: linux-kernel@vger.kernel.org
Subject: Info on ScatterGather
Date: Thu, 15 Nov 2001 11:24:16 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 17EAC9E919528-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

 I believe in the 2.4.x kernel LAN drivers can ask for scattered buffers on transmit. Is that what the NETIF_F_SG parm talks about? 

 Also, on the receive side, is buffer chaining possible? ie, if the device gives us 2 buffers (for a single frame), can the driver send those 2 buffers directly to the OS or should the driver combine it into a single buffer before calling netif_rx ()

thanx
HARISH V

