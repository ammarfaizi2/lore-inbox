Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129222AbQKPQrc>; Thu, 16 Nov 2000 11:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130540AbQKPQrY>; Thu, 16 Nov 2000 11:47:24 -0500
Received: from adsl-216-63-56-125.dsl.stlsmo.swbell.net ([216.63.56.125]:52999
	"EHLO dublin.innovates.com") by vger.kernel.org with ESMTP
	id <S129222AbQKPQqv>; Thu, 16 Nov 2000 11:46:51 -0500
X-OpenMail-Hops: 1
Date: Thu, 16 Nov 2000 10:16:49 -0600
Message-Id: <H00000650001978a.0974391408.dublin.innovates.com@MHS>
Subject: 2.2.18pre21 - IP kernel level autoconfiguration
MIME-Version: 1.0
From: (Chip Schweiss) chip@innovates.com
TO: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline; filename="BDY.TXT"
	;Creation-Date="Thu, 16 Nov 2000 10:16:48 -0600"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seem somewhere between 2.2.17 and the current 2.2.18 kernel, IP 
kernel level autoconfiguration has been broken.  Upon kernel loading 
the Ethernet card is detected and loaded properly, but the bootp code 
never seems to be executed and mounting the root partion via NFS  then 
fails from lack of IP configuration.

I haven't had any luck tracing down the root of this problem.  

Anyone else experience this problem or have a patch to fix it?

Chip Schweiss

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
