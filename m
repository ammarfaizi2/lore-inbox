Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRAYAnl>; Wed, 24 Jan 2001 19:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAYAnc>; Wed, 24 Jan 2001 19:43:32 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:57096
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129441AbRAYAnU>; Wed, 24 Jan 2001 19:43:20 -0500
Date: Wed, 24 Jan 2001 16:42:57 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: dmeyer@dmeyer.net
cc: linux-kernel@vger.kernel.org
Subject: Re: when is overriding idebus safe?
In-Reply-To: <20010124172038.A1431@jhereg.dmeyer.net>
Message-ID: <Pine.LNX.4.10.10101241637550.15294-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001 dmeyer@dmeyer.net wrote:

> The kernel always says:
> 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> 
> at boot time.  How would I know if it's safe to say idebus=66?  The
> documentation is fairly vague on this.

When the manual for your mainboard states that clock settings for setting
up your CPU creates a change in the normal idebus=33MHz of any other
value, then you are probablely safe.  Since all 32-bit PCI busses run at
33MHz, as last thought and reported, it should not be needed to change.
If I recall the idebus=XX primary use was for VLB/ISA/EISA systems, but I
have been wrong before.

Chers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
