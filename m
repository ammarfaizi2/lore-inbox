Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRJYM7X>; Thu, 25 Oct 2001 08:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRJYM7N>; Thu, 25 Oct 2001 08:59:13 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:35791 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S273255AbRJYM7D> convert rfc822-to-8bit; Thu, 25 Oct 2001 08:59:03 -0400
Subject: Re: dvd and filesystem errors under 2.4.13
From: christophe barbe <christophe.barbe.ml@online.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jim Hull <imaginos@imaginos.net>, linux-kernel@vger.kernel.org
In-Reply-To: <E15wjKP-0004fk-00@the-village.bc.nu>
In-Reply-To: <E15wjKP-0004fk-00@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.15 (Preview Release)
Date: 25 Oct 2001 14:59:34 +0200
Message-Id: <1004014775.7723.3.camel@turing>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1

Rev 6.2.1 from its mail.

I personnaly use rev 6.2.4 with the 2.4.13.

The patch for 2.4.12 apply fine.
	linux-aic7xxx-6.2.4-2.4.12.patch.gz

Christophe

PS: This rev (.4) include the pci table export for the hotplug stuff. I
hope this will be upgraded in the next stable kernel.

le jeu 25-10-2001 at 14:09 Alan Cox a écrit :
> > Oct 25 01:25:58 rosebud kernel: EXT2-fs error (device sd(8,1)):
> > ext2_free_blocks: bit already cleared for block 133384
> > Oct 25 01:25:58 rosebud kernel: EXT2-fs error (device sd(8,1)):
> > ext2_free_blocks: bit already cleared for block 133385
> 
> Thats indicating memory on on disk corruption. It is something you should
> be concerned about.  What version of aic7xxx is on the kernel that is
> stable ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

