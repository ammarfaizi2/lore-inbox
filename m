Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270333AbRH3IbK>; Thu, 30 Aug 2001 04:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270319AbRH3IbB>; Thu, 30 Aug 2001 04:31:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25102 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271068AbRH3Iav>; Thu, 30 Aug 2001 04:30:51 -0400
Subject: Re: PROBLEM: 2.4.9 bootup oops on kmalloc
To: sparky@ptw.com (Joe)
Date: Thu, 30 Aug 2001 09:34:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010830000525Z268971-760+7250@vger.kernel.org> from "Joe" at Aug 29, 2001 05:05:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cNHV-0000iU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> problem. (Old box never had any problem, new box does). Complains of kmalloc, 
> dies randomly on init processes with errors that aren't always the same. 
> Sysem is a 1.33ghz T-Bird on a KK266 w/ 2x512mb DIMM's @133mhz. Highmem is 
> turned on.

Try building a K6 optimised kernel. Some K7 boards/boxes dont survive under
the K7 kernel load
