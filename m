Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271906AbRHVGmQ>; Wed, 22 Aug 2001 02:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271926AbRHVGmF>; Wed, 22 Aug 2001 02:42:05 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:1210 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S271906AbRHVGlw>; Wed, 22 Aug 2001 02:41:52 -0400
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hugh@veritas.com (Hugh Dickins), andersee@debian.org (Erik Andersen),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Subject: Re: [Patch] sysinfo compatibility
In-Reply-To: <E15ZGRX-0008Qn-00@the-village.bc.nu>
Organisation: SAP LinuxLab
Date: 22 Aug 2001 08:40:32 +0200
In-Reply-To: <E15ZGRX-0008Qn-00@the-village.bc.nu>
Message-ID: <m3elq41tsv.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, 21 Aug 2001, Alan Cox wrote:
>> > There are callers who did add ram + swap
>> And that's a reason to break compatibility?
>  
> We had to break compatibility anyway for 2.4

Only for machines with more than 4G swap or ram, not swap +
ram. My patch addresses only this case where we did not fix anything
(for the kernel space) but broke something. Please keep in mind that
2-4 GB machines where quite common also for 2.2.

Greetings
		Christoph


