Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSHBPIr>; Fri, 2 Aug 2002 11:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSHBPIr>; Fri, 2 Aug 2002 11:08:47 -0400
Received: from mail.gmx.de ([213.165.64.20]:14906 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315179AbSHBPIq>;
	Fri, 2 Aug 2002 11:08:46 -0400
Date: Fri, 2 Aug 2002 17:12:18 +0200
From: gigerstyle@gmx.ch
To: linux-kernel@vger.kernel.org
Subject: Re: Booting problem, 2.4.19-rc5-ac1, ali15x3
Message-Id: <20020802171218.016b3d70.gigerstyle@gmx.ch>
In-Reply-To: <9cfd6t1nwuh.fsf@rogue.ncsl.nist.gov>
References: <9cfu1mp5kru.fsf@rogue.ncsl.nist.gov>
	<9cfd6t1nwuh.fsf@rogue.ncsl.nist.gov>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Aug 2002 10:45:10 -0400
Ian Soboroff <ian.soboroff@nist.gov> wrote:

Hi 

I have written before regarding the same problem. I noticed that I have mentioned the wrong kernel version. Of course I meant the 2.4.19-rc5-ac1 and 2.4.19-rc3-ac5. It happens on a Sony Vaio Gr114EK. I will now try the same solution like Ian.

greets

marc

> 
> Alan,
> 
> 2.4.19-rc5-ac1 hangs on boot on my laptop (Fujitsu P-series, TM5800
> CPU), whereas plain[1] rc5 boots fine.  The hang appears to be during IDE
> detection:
> 
> ...
> block: 704 slots per queue, batch=176
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=XX
> ALI15X3: IDE controller on PCI bus 00 dev 78
> PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq
> ALI15X3: chipset revision 195
> ALI15X3: not 100% native mode: will probe irqs later
> 
> With rc5, I get this same error unless I have 'ide0=ata66 ide1=ata66'
> on the kernel command line.  However, -ac1 hangs with or without these
> options.
> 
> I had this same problem under rc3-ac1, and rc2-ac2 (last two -ac
> kernels I tried), so this looks to be a long-term problem.  I'm hoping
> maybe I can help debug it before it gets into Marcelo's tree.
> 
> ian
> 
> [1] Actually, one one-liner patche to extend the ext3 journal
> commit interval to 30 seconds.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
