Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310459AbSCPR1x>; Sat, 16 Mar 2002 12:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310460AbSCPR1o>; Sat, 16 Mar 2002 12:27:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64520 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310459AbSCPR1h>; Sat, 16 Mar 2002 12:27:37 -0500
Subject: Re: Nice values for kernel modules
To: tigran@aivazian.fsnet.co.uk (Tigran Aivazian)
Date: Sat, 16 Mar 2002 17:42:44 +0000 (GMT)
Cc: kaos@ocs.com.au (Keith Owens), paulus@samba.org (Paul Mackerras),
        balbir_soni@yahoo.com (Balbir Singh),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0203161300300.1089-100000@einstein.homenet> from "Tigran Aivazian" at Mar 16, 2002 01:04:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mICa-0006mr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ability to bypass the stupid commercial time-locked licences (at some time
> wordperfect demo was locked like that and my timetravel module turned a
> demo into full product -- users were happy, at least according to emails I
> received :)

Not any more. Under the DMCA your time travel module probably makes you
a fugtive from US justice 8)

In general though calling into the syscall table by hand is a bad move. If
the function you are calling is generically useful then its much better to
work out whether the real function should be exported.


