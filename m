Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265744AbRF1NfP>; Thu, 28 Jun 2001 09:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265766AbRF1NfE>; Thu, 28 Jun 2001 09:35:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30220 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265744AbRF1Nes>; Thu, 28 Jun 2001 09:34:48 -0400
Subject: Re: SMP-Board, only 1 CPU, strange Crashes
To: puckwork@madz.net (Thomas Foerster)
Date: Thu, 28 Jun 2001 14:34:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010628132231Z265729-17720+8653@vger.kernel.org> from "Thomas Foerster" at Jun 28, 2001 03:19:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FbwL-0006wW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now the system runs fine for about 1 Week. After than, it oftens "crashes".
> "crashes" is not realy the thing ... diffrent things happen :

Unfortunately you dont give enough information to even take a wild guess

> The system is running on 2.4.4-ac18

Do try ac13 as well, there are some glitches in ac14+ with the new mm (ditto
in 2.4.6pre) that might cause hangs

> Whats happending to this box? I've never had such problems. Is it because of the
> Dual-Board and the non-smp kernel? (i need to know this, because we can't tolerate any more
> downtime right now)

Dual board with a non SMP kernel is fine. Make sure you have it set up 
correctly (terminators in place of 2nd cpu if required etc) but I dont think
its that. It could equally be bad ram, bad cpu etc..

run ac13 for a bit first see what occurs, then maybe memtest86 it

