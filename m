Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136522AbREANtz>; Tue, 1 May 2001 09:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136613AbREANtp>; Tue, 1 May 2001 09:49:45 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:25769 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S136522AbREANta>; Tue, 1 May 2001 09:49:30 -0400
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jamagallon@able.es (J . A . Magallon),
        R.E.Wolff@BitWizard.nl (Rogier Wolff),
        wakko@animx.eu.org (Wakko Warner),
        xavier.bestel@free.fr (Xavier Bestel),
        goswin.brederlow@student.uni-tuebingen.de (Goswin Brederlow),
        fluffy@snurgle.org (William T Wilson), Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <E14uI9f-0008Kt-00@the-village.bc.nu>
Organisation: SAP LinuxLab
In-Reply-To: <E14uI9f-0008Kt-00@the-village.bc.nu>
Message-ID: <m3n18xcral.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 01 May 2001 15:39:42 +0200
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Mon, 30 Apr 2001, Alan Cox wrote:
>> paging in just released 2.4.4, but in previuos kernel, a page that
>> was paged-out, reserves its place in swap even if it is paged-in
>> again, so once you have paged-out all your ram at least once, you
>> can't get any more memory, even if swap is 'empty'.
> 
> This is a bug in the 2.4 VM, nothing more or less. It and the
> horrible bounce buffer bugs are forcing large machines to remain on
> 2.2. So it has to get fixed

Yes, it is a bug. and thanks for stating this so clearly.

But a lot of the big servers can go to 2.4. because SYSV shm/shm
fs/tmpfs will reclaim the swap entries on swapin. So big databases and
applications servers which rely on shm are not affected.

Greetings
		Christoph


