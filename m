Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272242AbRHWMOP>; Thu, 23 Aug 2001 08:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272257AbRHWMN4>; Thu, 23 Aug 2001 08:13:56 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:260 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S272242AbRHWMNx>; Thu, 23 Aug 2001 08:13:53 -0400
Message-Id: <200108231214.f7NCE1k15642@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: linux-kernel@vger.kernel.org
Subject: hardware checksumming
Date: Thu, 23 Aug 2001 14:13:56 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is hardware support by a NIC for checksum generation / offloading not quite 
usless? the checksumming enging can only be used when UDP/TCP packets
are <= the MTU of the NIC (e.g 1500 bytes). 
i expact that UDP/TCP packets are in general bigger than that or is exactly 
that wrong and the network protokoll stack splits the data to be transfered 
so that each tcp packet is not bigger than the MTU. but whats with UPD there 
this wont work. 
 
