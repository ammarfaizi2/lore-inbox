Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286227AbRLTMpA>; Thu, 20 Dec 2001 07:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286231AbRLTMot>; Thu, 20 Dec 2001 07:44:49 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:32738
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S286228AbRLTMol>; Thu, 20 Dec 2001 07:44:41 -0500
Date: Thu, 20 Dec 2001 13:44:33 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17-rc2
Message-ID: <20011220134433.Q825@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh. Forgot l-k.

----- Forwarded message from Rasmus Andersen <rasmus@jaquet.dk> -----

On Tue, Dec 18, 2001 at 06:26:03PM -0200, Marcelo Tosatti wrote:
> 
> Hi,
> 
> So here it goes 2.4.17-rc2... as expected, bugfixes only.

Hi again.

Compiling rc2 I get the following:

make[1]: Leaving directory `/home/rasmus/kernel/linux-2417r2/arch/i386/math-emu'
gcc  -D__KERNEL__ -I/home/rasmus/kernel/linux-2417r2/include -e stext  arch/i386/vmlinux.lds.S   -o arch/i386/vmlinux.lds
/tmp/ccJtVuFa.s: Assembler messages:
/tmp/ccJtVuFa.s:2: Error: invalid character '_' in mnemonic
/tmp/ccJtVuFa.s:3: Error: invalid character '_' in mnemonic
/tmp/ccJtVuFa.s:4: Error: no such instruction: `sections'
/tmp/ccJtVuFa.s:5: Error: Rest of line ignored. First ignored character is `{'.
/tmp/ccJtVuFa.s:8: Fatal error: Symbol .text already defined.
make: *** [arch/i386/vmlinux.lds] Error 1

gcc is 2.96-85 from RH. as is 2.10.90. config is largish (and I
am clueless wrt. particular sections of interest) so it can
be gotten at http://www.jaquet.dk/kernel/2417rc2-config

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Even if you're on the right track, you'll get run over if you just sit there. 
  -- Will Rogers

----- End forwarded message -----
