Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282833AbRLBKbI>; Sun, 2 Dec 2001 05:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRLBKay>; Sun, 2 Dec 2001 05:30:54 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:33462 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S273588AbRLBKah>; Sun, 2 Dec 2001 05:30:37 -0500
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Wrapping memory.
In-Reply-To: <Pine.LNX.4.33.0112012249440.15977-100000@druid.if.uj.edu.pl>
	<E16AIZ8-0008Re-00@the-village.bc.nu>	<20011201205247.B31466@redhat.com>
Organisation: SAP LinuxLab
In-Reply-To: <20011201205247.B31466@redhat.com>
Message-ID: <m3u1vaauwr.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Date: 02 Dec 2001 11:24:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Sat, 1 Dec 2001, Benjamin LaHaise wrote:
>> mmap will do what you need. Create a 60K object on disk and mmap it
>> at the base address and then 60K further on for 4K. 
> 
> And try to use /dev/shm/ first...

If you can live with glibc >= 2.2 and kernel 2.4 you should use
shm_open, shm_unlink for object creation and deletion.

Greetings
		Christoph


