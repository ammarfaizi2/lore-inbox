Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132751AbRBEESb>; Sun, 4 Feb 2001 23:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132767AbRBEESL>; Sun, 4 Feb 2001 23:18:11 -0500
Received: from cr949225-b.rchrd1.on.wave.home.com ([24.112.58.97]:26640 "HELO
	enfusion-group.com") by vger.kernel.org with SMTP
	id <S132751AbRBEESC>; Sun, 4 Feb 2001 23:18:02 -0500
Date: Sun, 4 Feb 2001 23:17:53 -0500
From: Adrian Chung <adrian@enfusion-group.com>
To: Carlos Carvalho <carlos@fisica.ufpr.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dual Promise Ultra66 PCI Cards
Message-ID: <20010204231753.A3350@toad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <14974.10199.89722.67460@hoggar.fisica.ufpr.br>; from carlos@fisica.ufpr.br on Mon, Feb 05, 2001 at 02:11:03AM -0200
Organization: enfusion-group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2001 at 02:11:03AM -0200, Carlos Carvalho wrote:
> Adrian Chung (adrian@enfusion-group.com) wrote on 4 February 2001 15:53:
>  >I've been attempting to get two Promise Ultra66 controllers working
>  >with an Asus P2B-F motherboard.  I've got one controller successfully
>  >working, but as soon as I stick the second controller in the computer,
>  >the system refuses to boot.
>  >
>  >With 2.2.18 and the linux-ide patches (Uniform E-IDE 6.30), the
>  >computer refuses to boot if there are no bootable drives on the
>  >motherboard's IDE controllers.
> 
> The same happens with a P2B-DS. It has nothing to do with the kernel,
> the bios doesn't try to boot (from floppy in my case).

The BIOS doesn't try to boot, but if I switch my bootable linux drive
from the Ultra66 to the motherboard's controller, it boots just fine.
Up until it detects ide devices and tries to scan the hard drives.

Then linux just hangs...

--
Adrian Chung - adrian@enfusion-group.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
