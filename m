Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267463AbTBDUct>; Tue, 4 Feb 2003 15:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267467AbTBDUct>; Tue, 4 Feb 2003 15:32:49 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:47827 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267463AbTBDUcr>;
	Tue, 4 Feb 2003 15:32:47 -0500
Date: Tue, 4 Feb 2003 21:42:12 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Petr Sebor <petr@scssoft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VIA vt8235 headache
Message-ID: <20030204214212.B21554@ucw.cz>
References: <3E3EEF6E.6080107@scssoft.com> <1044360747.23312.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1044360747.23312.14.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 04, 2003 at 12:12:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 12:12:27PM +0000, Alan Cox wrote:

> If you remove just the DVD drive what occurs ?

The more reports I get the more i think this is a vt8235 hw-bug. Or
the vt8235 registers are different from all its predecessors.

I'll send a patch soonish to fix this. (it's the address setup
timing - it must be set to 0xff on a vt8235 or problems happen with
ATAPI devices).

> Also do you have ACPI support enabled, as that breaks a lot of systems
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
