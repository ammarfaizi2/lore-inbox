Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276988AbRJCVLF>; Wed, 3 Oct 2001 17:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276982AbRJCVKp>; Wed, 3 Oct 2001 17:10:45 -0400
Received: from web14802.mail.yahoo.com ([216.136.224.218]:22792 "HELO
	web14802.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276980AbRJCVKj>; Wed, 3 Oct 2001 17:10:39 -0400
Message-ID: <20011003211108.16017.qmail@web14802.mail.yahoo.com>
Date: Wed, 3 Oct 2001 14:11:08 -0700 (PDT)
From: Linux Bigot <linuxopinion@yahoo.com>
Subject: Re: how to get virtual address from dma address
To: Ben Collins <bcollins@debian.org>
Cc: jes@sunsite.dk, linux-kernel@vger.kernel.org
In-Reply-To: <20011003153251.F319@visi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then why isn't there a call like pci_unmap_single()


Thanks


--- Ben Collins <bcollins@debian.org> wrote:
> On Wed, Oct 03, 2001 at 09:37:00AM -0700, Linux
> Bigot wrote:
> > Please tell me why can't I use bus_to_virt().
> 
> Because bus_to_virt/virt_to_bus is obsolete, and
> using it will make your
> driver non-portable to some architectures.
> 
> -- 
> 
>
.----------=======-=-======-=========-----------=====------------=-=-----.
> /                   Ben Collins    --    Debian
> GNU/Linux                  \
> `  bcollins@debian.org  --  bcollins@openldap.org 
> --  bcollins@linux.com  '
> 
`---=========------=======-------------=-=-----=-===-======-------=--=---'


__________________________________________________
Do You Yahoo!?
NEW from Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
