Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKKVss>; Sat, 11 Nov 2000 16:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQKKVsi>; Sat, 11 Nov 2000 16:48:38 -0500
Received: from 255.255.255.255.in-addr.de ([212.8.197.242]:16144 "HELO
	255.255.255.255.in-addr.de") by vger.kernel.org with SMTP
	id <S129044AbQKKVsb>; Sat, 11 Nov 2000 16:48:31 -0500
Date: Sat, 11 Nov 2000 22:48:16 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Cc: "Matt D. Robinson" <yakker@alacritech.com>, Christoph Rohland <cr@sap.com>,
        richardj_moore@uk.ibm.com, Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re:  [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Message-ID: <20001111224816.A1234@marowsky-bree.de>
In-Reply-To: <3A0C402F.8F0BA261@alacritech.com> <200011110012.TAA22015@tsx-prime.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <200011110012.TAA22015@tsx-prime.MIT.EDU>; from "Theodore Y. Ts'o" on 2000-11-10T19:12:29
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2000-11-10T19:12:29,
   "Theodore Y. Ts'o" <tytso@MIT.EDU> said:

> Great!  Are you thinking about putting the crash dumper and the raw
> write disk routines in a separate text section, so they can be located
> in pages which are write-protected from accidental modification in case
> some kernel code goes wild?  (Who me?  Paranoid?  :-)

I would also suggest to have a little checksum over the relevant pages, to
verify that the code is still correct and we are not going to crashdump all
over our valuable data...

And I am still very fond of the idea of crash dumping to a network server ;-)

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>
    Development HA

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
