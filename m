Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbRCLPWh>; Mon, 12 Mar 2001 10:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbRCLPWR>; Mon, 12 Mar 2001 10:22:17 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:34831 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130446AbRCLPWG>;
	Mon, 12 Mar 2001 10:22:06 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dhd@eradicator.org (David Huggins-Daines), linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: allow notsc option for buggy cpus
In-Reply-To: <E14bhfX-0006hg-00@the-village.bc.nu>
From: Jes Sorensen <jes@linuxcare.com>
Date: 12 Mar 2001 16:21:01 +0100
In-Reply-To: Alan Cox's message of "Sat, 10 Mar 2001 11:36:17 +0000 (GMT)"
Message-ID: <d3elw3nhcy.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> I think this behaviour can be controlled with tpctl for the
>> Thinkpads and possibly with the Toshiba utils on Toshibas...

Alan> If tpctl can do it and we know how it does it then that may be
Alan> sufficient since the kernel init code can use DMI to find the
Alan> 600E, tpctl copied code to go to high speed, bogomip it and then
Alan> drop back.

Well I can confirm that tpctl allows you to disable it and run the cpu
at 400MHz all the time, thats what I did for my 600E.

Jes
