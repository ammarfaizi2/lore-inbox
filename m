Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283477AbRLEHxy>; Wed, 5 Dec 2001 02:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283498AbRLEHxp>; Wed, 5 Dec 2001 02:53:45 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:16080 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S283477AbRLEHxb>; Wed, 5 Dec 2001 02:53:31 -0500
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: padraig@antefacto.com (Padraig Brady), linux-kernel@vger.kernel.org
Subject: Re: question about kernel 2.4 ramdisk
In-Reply-To: <E16BLxI-0003Ic-00@the-village.bc.nu>
Organisation: SAP LinuxLab
Date: 05 Dec 2001 08:49:37 +0100
In-Reply-To: <E16BLxI-0003Ic-00@the-village.bc.nu>
Message-ID: <m37ks2qf72.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, 4 Dec 2001, Alan Cox wrote:
>> wrt the ramfs leak (the referenced patch below worked for me),
>> is the ramfs usage limits patch + this fix going into
>> the official 2.4 soon as it was in the ac series for ages?
> 
> The -ac ramfs changes need the mm operations changes. Someone has to
> go merge that with Andrea-vm then you can get ramfs fixed and
> accounting sorted out in shmfs

To be pendantic here: Accounting is right in tmpfs (^=shmfs).

What's missing is the global statistic of how many in memory pages in
the page cache are actually tmpfs pages.

Greetings
		Christoph


