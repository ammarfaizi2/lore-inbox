Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965317AbWFAV1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965317AbWFAV1T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbWFAV1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:27:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:26989 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965317AbWFAV1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:27:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TERHwlz/0+o0dP6KcdBT70KKbEB23ypZd1hF7uzInLcmT8toNC5yvYrTh5OGDHn5ArAvwCqL1Ps9Y02w+lG0aINxF1cqFU8Iei7v5qjsrV/HF3UaceO+2MpTuPbtFdwHI0n+yPUzI5uaBHdc0/pSOg1T7hNGEirEwR57ZEGkuhI=
Message-ID: <20f65d530606011427i2cf453f0rf84bc3c0814f6687@mail.gmail.com>
Date: Fri, 2 Jun 2006 09:27:17 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: "Thiago Galesi" <thiagogalesi@gmail.com>
Subject: Re: IO APIC IRQ assignment
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <82ecf08e0606010858u3a31c46bx6bb8c340580cb993@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
	 <20060530135017.GD5151@harddisk-recovery.com>
	 <20f65d530605300705l60bfcca7k47a41c95bf42a0ef@mail.gmail.com>
	 <Pine.LNX.4.61.0606010002200.30170@yvahk01.tjqt.qr>
	 <20f65d530605311612n15820847sca559d0c443fc230@mail.gmail.com>
	 <20060601094214.GA14431@harddisk-recovery.com>
	 <20f65d530606010338h23dbd152u2670000ba6130fc6@mail.gmail.com>
	 <20f65d530606010835h76356757k3d3714203d5e4c6@mail.gmail.com>
	 <82ecf08e0606010858u3a31c46bx6bb8c340580cb993@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thiago

> On a side note, did you consider that, for that purpose, the system
> you're using may be underpowered (that is, not enough CPU / Bus
> speed)??
>
> Depending on your system configuration, plus frequency and resolution
> of frame acquisition, yes, it's not going to work.
>

I doubt that is the case. We are using a Pentium M 1.8GHz, and only
capturing low resolution 3 fps from bttv. Wifi data transfer is only
done in small chunks (we split the data in chunks at the application
level, ie p2p file sharing concept). CPU usage is extremely low, ie
less than 5%.

>
> I've already encountered the PCI latency problem in a similar project
> (using BTTVs, the image would be missing some lines) with not so
> frequent captures and two BTTVs on the system)
>

How did you solve your problem in that project?

Regards
Keith
