Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129965AbQLXVTi>; Sun, 24 Dec 2000 16:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130255AbQLXVT1>; Sun, 24 Dec 2000 16:19:27 -0500
Received: from web1002.mail.yahoo.com ([128.11.23.92]:14088 "HELO
	web1002.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129965AbQLXVTL>; Sun, 24 Dec 2000 16:19:11 -0500
Message-ID: <20001224204844.3587.qmail@web1002.mail.yahoo.com>
Date: Sun, 24 Dec 2000 12:48:44 -0800 (PST)
From: Ron Calderon <ronnnyc@yahoo.com>
Subject: Re: sparc 10 w/512 megs hangs during boot
To: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just finished compiling 2.4.0-test5 and that worked
fine with 512M ram. I'll start going thru the other
kernels. It'll take me sometime since compileing takes
a long time.


ron
--- Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Sat, Dec 23, 2000 at 11:57:21PM -0800, Ron
> Calderon wrote:
> > My sparc 10 seems to hang with any 2.4.0-test12+
> > kernel
> 
> ...but 2.4.0-test11-X kernels are fine? Well, good
> info;)
> 
> > if I add mem=128M it boots fine, but anything
> above
> > 128M wont boot it just hangs. Is there something
> I've
> > missed? here is screen output.
> 
> I see this as well (SS10 dual with 128MB RAM).
> However, if
> slightly older kernel are okay, then it's quite easy
> to look
> through the patches. Which is your
> last-known-to-be-good kernel?
> 
> > Uncompressing image...
> > PROMLIB: obio_ranges 5
> > bootmem_init: Scan sp_banks, 
> > init_bootmem(spfn[1c9],bpfn[1c9],mlpfn[c000])
> > free_bootmem: base[0] size[c000000]
> > reserve_bootmem: base[0] size[1c9000]
> > reserve_bootmem: base[1c9000] size[1800]
> > 
> > then it just hangs here....
> 
> I additionally get "Unexpected Level 15 Interrupt"
> und "Program
> terminated" ;-)
> 
> MfG, JBG
> 
> -- 
> Fehler eingestehen, Größe zeigen: Nehmt die
> Rechtschreibreform zurück!!!
> /* Jan-Benedict Glaw <jbglaw@lug-owl.de> --
> +49-177-5601720 */
> keyID=0x8399E1BB fingerprint=250D 3BCF 7127 0D8C
> A444 A961 1DBD 5E75 8399 E1BB
>      "insmod vi.o and there we go..." (Alexander
> Viro on linux-kernel)
> 

> ATTACHMENT part 2 application/pgp-signature 



__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
