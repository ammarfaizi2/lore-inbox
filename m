Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289021AbSANUtc>; Mon, 14 Jan 2002 15:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSANUtX>; Mon, 14 Jan 2002 15:49:23 -0500
Received: from ns.suse.de ([213.95.15.193]:39440 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289021AbSANUtM>;
	Mon, 14 Jan 2002 15:49:12 -0500
Date: Mon, 14 Jan 2002 21:49:11 +0100
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Charles Cazabon <linux@discworld.dyndns.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114214911.O15139@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Charles Cazabon <linux@discworld.dyndns.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020114132618.G14747@thyrsus.com> <m16QCNJ-000OVeC@amadeus.home.nl> <20020114145035.E17522@thyrsus.com> <20020114142605.A4702@twoflower.internal.do> <20020114151942.A20309@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020114151942.A20309@thyrsus.com>; from esr@thyrsus.com on Mon, Jan 14, 2002 at 03:19:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 03:19:42PM -0500, Eric S. Raymond wrote:
 > > > compiled in.  Am I going to have to open this puppy up just to eyeball
 > > > the hardware?"
 > > Uh, no.  Try `lsmod`.
 > He hard-compiled in that driver.  lsmod(1) can't see it.

 $ grep eth0 /var/log/boot.msg
 <6>eth0: PCnet/FAST+ 79C972 at 0x9400, 00 a0 d2 18 c0 2c

 (Ok, it's not ISA, but it serves a point).
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
