Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbRDORyJ>; Sun, 15 Apr 2001 13:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132771AbRDORyA>; Sun, 15 Apr 2001 13:54:00 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:43732 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132567AbRDORxn>;
	Sun, 15 Apr 2001 13:53:43 -0400
Message-ID: <3AD9E021.3B38D309@mandrakesoft.com>
Date: Sun, 15 Apr 2001 13:53:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Cami <francois.cami@supelec.fr>
Cc: "Matthew W. Lowe" <swds.mlowe@home.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 - Module problems?
In-Reply-To: <3ADAC95A.6B35B8DE@home.com> <3AD9DDAF.5E76F797@supelec.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Cami wrote:
> 
> hi Matthew and everyone
> 
> I use a 3COM Etherlink III ISA and a 3C905C PCI in my firewall
> box (i440BX mobo). (distro is slackware 7.1, kernels are either
> 2.2.19 or 2.4.3, modutils 2.3.1 (slackware 7.1 default) ).
> 
> The 3C905C was never a problem (and i guess your R8029 isn't either),
> however to make the 3C509 ISA work, I had to disable PnP in the
> card's firmware, with 3COM tools : see
> 
> http://www.3com.com/products/html/prodlist.html?family=570&cat=20&pathtype=download&tab=cat&selcat=Network%20Interface%20Cards%20%26%20Adapters
> 
> to download the DOS tools to configure your card without PnP, i.e.
> manually
> assigning an IRQ and address to it.
> 
> You'll have to declare to your BIOS that this particular IRQ is taken
> by a non-PNP ISA card too.

You can also use the Linux program
ftp://www.scyld.com/pub/diag/3c5x9setup.c

-- 
Jeff Garzik       | "Give a man a fish, and he eats for a day. Teach a
Building 1024     |  man to fish, and a US Navy submarine will make sure
MandrakeSoft      |  he's never hungry again." -- Chris Neufeld
