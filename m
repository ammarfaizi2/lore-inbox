Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVDTShL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVDTShL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 14:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVDTShL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 14:37:11 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:13934 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261793AbVDTShA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 14:37:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rYNpgR7ilE7LAdo+cZScABZYRTp/Y0AgueWtiZMJtv4M7incAzacT9mjHOmo+qAwfIY2DlOgETdkRaZT54q9UVu3oDIhaWJ9UlodgQQR26kcOLxobQzTr7T1TAO03MkDqtzh7SmJQ5af2yr3n/Ny31slX+lR3kJ1hdo4n3ufqaY=
Message-ID: <2a4f155d05042011361234531d@mail.gmail.com>
Date: Wed, 20 Apr 2005 21:36:59 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: NForce4 ide problems?
In-Reply-To: <2a4f155d050420081220b3f801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2a4f155d050420081220b3f801@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW problem happens way before any driver is loaded ( i.e nVidia ) so
this is not a such problem.


On 4/20/05, ismail dönmez <ismail.donmez@gmail.com> wrote:
> Hi all,
> 
> I recently bought an Asus A8N-SLI mobo and an AMD 3500+ CPU for my
> system but my ide drive seems to have some problems with them. Here is
> what I get at boot :
> 
> <snip>
> hda: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63,
> UDMA(100)
> hda: cache flushes supported
>  /dev/ide/host0/bus0/target0/lun0:hda: dma_intr: status=0x51 {
> DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> </snip>
> 
> First I thought it was bad ide cable ( because I wasn't using the one
> that came with mobo ) so I tried with the brand new cable coming with
> mobo and same error happened. Also trying to do something like :
> 
> hdparm -m16 -c -u1 -d1 -Xudma2 /dev/hda
> 
> results in a cpu exception thrown and a kernel panic after that. Full
> dmesg log is attached. I appreciate any help/comments.
> 
> P.S: I tried with kernel 2.6.10 and 2.6.12-rc2 and same problems happen
> 
> Regards,
> ismail
> 
> 
> -- 
> Time is what you make of it
> 
> 

-- 
Time is what you make of it
