Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131187AbRAPQHI>; Tue, 16 Jan 2001 11:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRAPQG6>; Tue, 16 Jan 2001 11:06:58 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:22659 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129805AbRAPQGy>; Tue, 16 Jan 2001 11:06:54 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9518C@ATL_MS1> 
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9518C@ATL_MS1> 
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux not adhering to BIOS Drive boot order? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Jan 2001 16:06:46 +0000
Message-ID: <29608.979661206@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Venkateshr@ami.com said:
>  we need some kind of signature being written in the drive, which the
> kernel will use for determining the boot drive and later re-order
> drives, if required.

> Is someone handling this already? 

It should be possible to read the BIOS setting for this option and
behave accordingly. Please give full details of how to read and interpret
the information stored in the CMOS for all versions of AMI BIOS, and I'll
take a look at this.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
