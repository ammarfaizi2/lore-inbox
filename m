Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263222AbREaUnE>; Thu, 31 May 2001 16:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbREaUmz>; Thu, 31 May 2001 16:42:55 -0400
Received: from t2.redhat.com ([199.183.24.243]:65018 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S263221AbREaUml>; Thu, 31 May 2001 16:42:41 -0400
Message-ID: <3B16ACBC.E9BB936F@redhat.com>
Date: Thu, 31 May 2001 21:42:36 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, esr@thyrsus.com
Subject: Re: Configure.help is complete
In-Reply-To: <5.1.0.14.1.20010531130356.00aaba18@sandbox.jaggnet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BH wrote:
> 
> Great work, its nice to see none, or fewer No help availables in the kernel
> configuration.
> Some quick glances:
> 
> Linux Kernel v2.4.5-ac5 Configuration
> CML1
> 
> Bottom of IDE, ATA and ATAPI Block devices;
> 
> < > Support Promise software RAID (NEW)   -> Help
> There is no help available for this kernel option.

How about
"Say "Y" or "M" if you have a Promise Fasttrak (tm) Raid controller
and want linux to use the softwarraid feature of this card.
This driver uses /dev/ataraid/dXpY (X and Y numbers) as device names.

If you have a Promise Fasttrak(tm) card but do not use the BIOS provided
raid feature, say "N".
