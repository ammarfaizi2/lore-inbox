Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132356AbQLHSKU>; Fri, 8 Dec 2000 13:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132334AbQLHSKA>; Fri, 8 Dec 2000 13:10:00 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:34311 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132319AbQLHSJ7>; Fri, 8 Dec 2000 13:09:59 -0500
Date: Fri, 8 Dec 2000 11:35:21 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001208113521.C4730@vger.timpanogas.org>
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org> <20001207221347.R6567@cadcamlab.org> <3A3066EC.3B657570@timpanogas.org> <20001208005337.A26577@alcove.wittsend.com> <3A306994.63DB8208@timpanogas.org> <4.3.2.7.2.20001208081657.00b15220@mail.osagesoftware.com> <20001208144342.B25391@khan.acc.umu.se> <20001208153408.A19802@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001208153408.A19802@lug-owl.de>; from jbglaw@lug-owl.de on Fri, Dec 08, 2000 at 03:34:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 03:34:09PM +0100, Jan-Benedict Glaw wrote:
> On Fri, Dec 08, 2000 at 02:43:42PM +0100, David Weinehall wrote:
> > On Fri, Dec 08, 2000 at 08:19:46AM -0500, David Relson wrote:
> > > At 11:54 PM 12/7/00, Jeff V. Merkey wrote:
> 
> > No amount of warnings can prevent morons from f**king up. Unix gives
> > you enough rope et al. I'm not arguing for removal of any warning, but
> > seriously, if we have a loud (DANGEROUS) warning in the config-system
> > aaaaaand a warning in the help-text that the write-support probably will
> > mess up your fs, how much more can you do? I bet that if we remove the
> 
> Well, simply insert sth. like this into ./fs/ntfs/fs.c:parse_options()
> 
> printk(KERN_EMERG "You're likely to crash your NTFS if you do any "
> 	"write attempts to it. NTFS write support is broken and for "
> 	"developers *only*. Do only use this if you're debugging it, "
> 	"never ever use this on data you'd like to see tomorrow "
> 	"again!!! Please remount in read-only mode *now* or don't "
> 	"complain afterwards!  

And add:

        If you persist in using this, www.timpanogas.org will provide
        tools to help you recover your data.);
Jeff

");
> 
> Maybe that can prevent pupils^H^H^H^H^Heople from shooting their
> foots...
> 
> MfG, JBG
> 
> -- 
> Fehler eingestehen, Größe zeigen: Nehmt die Rechtschreibreform zurück!!!
> /* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
> keyID=0x8399E1BB fingerprint=250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 8399 E1BB
>      "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
