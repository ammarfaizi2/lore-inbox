Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269144AbRHBU7Z>; Thu, 2 Aug 2001 16:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269157AbRHBU7P>; Thu, 2 Aug 2001 16:59:15 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:58895 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S269152AbRHBU66>; Thu, 2 Aug 2001 16:58:58 -0400
Date: Thu, 2 Aug 2001 15:02:16 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, langus@timpanogas.org
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: 3ware Escalade problems
Message-ID: <20010802150216.A25975@vger.timpanogas.org>
In-Reply-To: <20010801185836.B22548@vger.timpanogas.org> <E15SHUV-0000SM-00@the-village.bc.nu> <20010802142631.A25795@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010802142631.A25795@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Thu, Aug 02, 2001 at 02:26:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan,

On a related problem, we are seeing packet checksum corruption with both
the 3Com and Intel Gigabit ethernet adapters when a ping -f -s > 1472 packet
fllods are initiated.  The sniffers report packets with corrupted checksum
information.  I am copying Larry Angus on this email since he has all 
the sniffer traces.  These problems show up on 2.2 and 2.4 kernels.

We noticed several emails in the archive regarding this problem, but 
no fixes reported.  What's disturbing regarding this issue is that 
hardware checksum errors are being generated which results in the 
packets being lost.

Larry - please provide the traces and documentation you have discovered
to Alan regarding this problem.

Jeff

