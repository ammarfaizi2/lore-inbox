Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbRAWL31>; Tue, 23 Jan 2001 06:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129944AbRAWL3R>; Tue, 23 Jan 2001 06:29:17 -0500
Received: from Cantor.suse.de ([194.112.123.193]:15882 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130113AbRAWL27>;
	Tue, 23 Jan 2001 06:28:59 -0500
Date: Tue, 23 Jan 2001 12:28:49 +0100
From: Karsten Keil <kkeil@suse.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Keith Owens <kaos@ocs.com.au>, Karsten Keil <keil@isdn4linux.de>,
        linux-kernel@vger.kernel.org
Subject: Re: BUG in modutils or drivers/isdn/hisax/
Message-ID: <20010123122849.A27379@gruyere.muc.suse.de>
Mail-Followup-To: Karsten Keil <kkeil@suse.de>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Keith Owens <kaos@ocs.com.au>, Karsten Keil <keil@isdn4linux.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010123013155.E1173@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010123013155.E1173@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Tue, Jan 23, 2001 at 01:31:55AM +0100
Organization: SuSE Muenchen GmbH
X-Operating-System: Linux 2.2.10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 23, 2001 at 01:31:55AM +0100, Ingo Oeser wrote:
> Hi Keith,
> hi Karsten,
> hi linux-kernel,
> 
> the current modutils (2.4.1) cannot read the
> __module_pci_device_table of a kernel/drivers/isdn/hisax/hisax.o
> module of linux 2.4.0 (vanilla).
> 
> What's wrong with it?

Nothing. Only the HFC-PCI part in hisax has such a table yet, all other
card drivers in hisax don't have one at the moment.

-- 
Karsten Keil
SuSE Labs
ISDN development
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
