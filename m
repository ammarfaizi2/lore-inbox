Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268868AbUHUHCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268868AbUHUHCf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 03:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268869AbUHUHCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 03:02:35 -0400
Received: from qfep04.superonline.com ([212.252.122.160]:43717 "EHLO
	qfep04.superonline.com") by vger.kernel.org with ESMTP
	id S268868AbUHUHCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 03:02:34 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Aidas Kasparas'" <a.kasparas@gmc.lt>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 10:02:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <4126F16D.1000507@gmc.lt>
Thread-Index: AcSHS5VHAD8yA25VSci2zXgXImAHXgACKFZA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S268868AbUHUHCe/20040821070234Z+1825@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is definetely impossible to use IPTables to handle packets with incorrect
checksums since NAT would drop the connection right away, otherwise I would
not have been asking this question here.

-----Original Message-----
From: Aidas Kasparas [mailto:a.kasparas@gmc.lt] 
Sent: Saturday, August 21, 2004 8:54 AM
To: Josan Kadett
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

How about setting up a separate box which would listen on that 
192.168.77.1 address and MASQUERADE connections to your crazy box from 
192.168.1.x address? Maybe then you would no longer need to break things 
  in kernel?



