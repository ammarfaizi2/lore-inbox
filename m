Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277389AbRJEOM5>; Fri, 5 Oct 2001 10:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277388AbRJEOMr>; Fri, 5 Oct 2001 10:12:47 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:4275 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S277386AbRJEOMa>;
	Fri, 5 Oct 2001 10:12:30 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: ioremap() vs. ioremap_nocache()
In-Reply-To: <E15pFPM-00044b-00@the-village.bc.nu>
From: Jes Sorensen <jes@sunsite.dk>
Date: 05 Oct 2001 16:12:49 +0200
In-Reply-To: Alan Cox's message of "Thu, 4 Oct 2001 21:47:52 +0100 (BST)"
Message-ID: <d3itdutbtq.fsf@lxplus014.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Now, as far as I know, on x86, ioremap() will give write-through
>> cached mappings (in the absence of mtrr games).  If this is true,
>> how

Alan> On x86 ioremap will give mappings appropriate to the object you
Alan> map - which means by default it wil give uncached mappings. The
Alan> PCI hardware will do intelligent things in certain cases such as
Alan> write merging

Are you thereby saying that ioremap() and ioremap_nocache() are
identical on the x86?

Cheers,
Jes
