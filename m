Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132158AbQLHOOl>; Fri, 8 Dec 2000 09:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbQLHOOb>; Fri, 8 Dec 2000 09:14:31 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:60917 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S132158AbQLHOOX>; Fri, 8 Dec 2000 09:14:23 -0500
Date: Fri, 8 Dec 2000 14:43:42 +0100
From: David Weinehall <tao@acc.umu.se>
To: David Relson <relson@osagesoftware.com>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        "Michael H. Warfield" <mhw@wittsend.com>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001208144342.B25391@khan.acc.umu.se>
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org> <20001207221347.R6567@cadcamlab.org> <3A3066EC.3B657570@timpanogas.org> <20001208005337.A26577@alcove.wittsend.com> <3A306994.63DB8208@timpanogas.org> <4.3.2.7.2.20001208081657.00b15220@mail.osagesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <4.3.2.7.2.20001208081657.00b15220@mail.osagesoftware.com>; from relson@osagesoftware.com on Fri, Dec 08, 2000 at 08:19:46AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 08:19:46AM -0500, David Relson wrote:
> At 11:54 PM 12/7/00, Jeff V. Merkey wrote:
> 
> 
> >Linux today monitors this list.  Some public education may be the best
> >route.  How do we post a security advisory warning people that will get
> >posted?  I'm sure folks see the DANGEROUS comments, but they don't seem
> >to stick in their heads.  Then they get themselves into trouble, and
> >fortunately for them, I'm around.  I am just concerned about the scope
> >of the black eye that will just keep getting bigger and bigger for Linux
> >NTFS.
> 
> 
> FWIW, Mandrake Linux includes a tool MandrakeUpdate which allows 
> downloading of "Normal Updates" or "Development Updates".  If you chose 
> Devel Upd, you get the following warning:
> 
>          Caution !  These packages are NOT well tested.
>          You really can screw up your system
>          by installing them.
> 
> Perhaps the configure tools could recognize a DANGEROUS status (or keyword 
> or ???) and would display such a message ...

No amount of warnings can prevent morons from f**king up. Unix gives
you enough rope et al. I'm not arguing for removal of any warning, but
seriously, if we have a loud (DANGEROUS) warning in the config-system
aaaaaand a warning in the help-text that the write-support probably will
mess up your fs, how much more can you do? I bet that if we remove the
config-option, people will still enable it manually, then go "Waaaaa,
your stupid kernel messed up my filesystem, Linux sucks!"

But I kind of liked the

Enable write support (DANGEROUS)
  Really enable write support (DANGEROUS)
    Are you f**king nuts?!

approach anyway. A strong candidate for Rik van Riel's patch-of-the-month
homepage.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
