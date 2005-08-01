Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVHAT3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVHAT3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVHAT3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:29:21 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:60262 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261182AbVHAT2z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:28:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eyRtqfT2aUFNNa6aYeKZe2lskcMkjsdhJONFUfP1Yy4499cVwcysKfX6j6rrpQDu6jlv7/gxeNnv0i8eCRRAYK19QTBnhGH4rYZJtSXMBmB5YcxAYlN2REe04+sfqHtyptSLEfPi6UeFDUeE5Jt3nke6K4wH1JGE6+CQ+idQ2ro=
Message-ID: <58cb370e050801122831a97873@mail.gmail.com>
Date: Mon, 1 Aug 2005 21:28:54 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
Cc: Alexander Fieroch <fieroch@web.de>, Alexey Dobriyan <adobriyan@gmail.com>,
       Michael Thonke <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Natalie.Protasevich@unisys.com, Andrew Morton <akpm@osdl.org>,
       Parag Warudkar <kaernel-stuff@comcast.net>
In-Reply-To: <m3oe8h7978.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d6gf8j$jnb$1@sea.gmane.org> <42EAAFD4.4010303@web.de>
	 <42EAD086.4010904@gmail.com>
	 <200507291905.37339.kernel-stuff@comcast.net>
	 <20050730014237.GA20131@mipter.zuzino.mipt.ru>
	 <42EE33F6.6040606@web.de> <m3oe8h7978.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/05, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Alexander Fieroch <fieroch@web.de> writes:
> 
> > hdb: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
> > hdb: media error (bad sector): error=0x30 { LastFailedSense=0x03 }
> > ide: failed opcode was: unknown
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > end_request: I/O error, dev hdb, sector 1306960
> > Buffer I/O error on device hdb, logical block 326740
> 
> BTW: I believe this used to point to something useful rather than
> to "unknown opcode". Is it just a bug or does it really not know
> the opcode?

For regular FS requests it really doesn't know ATA opcode...
(on the TODO)
