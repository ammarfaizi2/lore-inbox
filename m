Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276129AbRI1PbI>; Fri, 28 Sep 2001 11:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276131AbRI1Pa6>; Fri, 28 Sep 2001 11:30:58 -0400
Received: from r220-1.rz.RWTH-Aachen.DE ([134.130.3.31]:45520 "EHLO
	r220-1.rz.RWTH-Aachen.DE") by vger.kernel.org with ESMTP
	id <S276129AbRI1Pat>; Fri, 28 Sep 2001 11:30:49 -0400
Message-ID: <3BB49788.100E68FD@die-macht.oph.rwth-aachen.de>
Date: Fri, 28 Sep 2001 17:30:16 +0200
From: Stefan Becker <stefan@die-macht.oph.rwth-aachen.de>
Reply-To: stefan@oph.rwth-aachen.de
Organization: OPH Netzwerkgruppe
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac16
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Alan Cox wrote:
> *       Update the VM to Rik's latest bits

"swapoff -a" gives:

Sep 28 17:25:25 unknown kernel: Trying to vfree() nonexistent vm area
(e105a000)

That was after I've run "eatmem" to fill all physical and swap memory.
The maschine was totally frozen while "eatmem" was running and control+C
took 2 
minutes to take effect.
The box returned with a load > 9.

Greetings,
Stefan
