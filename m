Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132117AbRAXSFu>; Wed, 24 Jan 2001 13:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132105AbRAXSFc>; Wed, 24 Jan 2001 13:05:32 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:28680
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131492AbRAXSF0>; Wed, 24 Jan 2001 13:05:26 -0500
Date: Wed, 24 Jan 2001 10:04:50 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
In-Reply-To: <20010121104606.A398@suse.cz>
Message-ID: <Pine.LNX.4.10.10101241003270.14153-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2001, Vojtech Pavlik wrote:

> On Sat, Jan 20, 2001 at 02:57:07PM -0800, Andre Hedrick wrote:
> 
> > Vojtech, I worry that the dynamic timing that you are calculating could
> > bite you. 
> 
> Well, I know this. But I fear hardcoded timings won't really help here,
> unles everyone out there ran their chipsets at 33 MHz, in which case the

You have to run the ATA Chipset at 33MHz or it will fail in 99% of all
cases.  This is not the FSB running at 66/83/100/133.  So hardcode is
correct.

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
