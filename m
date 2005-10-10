Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVJJRrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVJJRrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVJJRrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:47:12 -0400
Received: from mail.zyxel.com ([65.170.185.66]:40908 "EHLO zyxel.com")
	by vger.kernel.org with ESMTP id S1751090AbVJJRrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:47:12 -0400
Reply-To: <ken.hwang@zyxel.com>
From: "Ken Hwang" <ken.hwang@zyxel.com>
To: "Lukasz Kosewski" <lkosewsk@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, "Jeff Garzik" <jgarzik@pobox.com>
Subject: RE: Anybody know about nforce4 SATA II hot swapping + linux raid?
Date: Mon, 10 Oct 2005 10:47:00 -0700
Message-ID: <HIENIDNHFMODBIPFNJPDAECLCMAA.ken.hwang@zyxel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1250"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
In-Reply-To: <355e5e5e0510080801p88f04c7x7992c3d75f20e65c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

I'm interested in getting the SATA hot-swapping code/patch and try it with
my PromiseTX4 and VIA SATA controllers. Would you please show me where is
the code? I tried to download from Jeff's folder in kernel.org but somehow I
could not untar the file. I felt  it may be encrypted. Please help if it's
possible.

Thanks,

Ken

-----Original Message-----
From: linux-raid-owner@vger.kernel.org
[mailto:linux-raid-owner@vger.kernel.org]On Behalf Of Lukasz Kosewski
Sent: Saturday, October 08, 2005 8:01 AM
To: Andrew Walrond
Cc: linux-kernel@vger.kernel.org; Molle Bestefich; htejun@gmail.com;
linux-raid@vger.kernel.org; Jeff Garzik
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?


On 10/8/05, Andrew Walrond <andrew@walrond.org> wrote:
> The lack of hot swapping does seem to be a serious weakness in linux, at
least
> for resilient server applications. It would really complete the linux raid
> picture, and make it quite compelling.
>
> But I'm in no position to do it myself; I can only hope this thread
inspires
> some capable person to plug the gap :)

Hey Andrew,

I've actually been working on implementing the core set of routines
that will allow for hot-swapping SATA drives in Linux.  The core is
not quite ready yet, but you can expect the next iteration within the
week.  Once the core is integrated, someone will have to implement
capturing hotswap events on the nForce4 SATA controller, and using the
core functions.  I don't know how long that will take, but if the
Linux SATA maintainer, Jeff Garzik (CCed on this email) knows how to
do it, then it might be just a few weeks' time.

That said, if you want to use this for servers you might still want to
wait a bit before committing your resources to this :)

Luke Kosewski
-
To unsubscribe from this list: send the line "unsubscribe linux-raid" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
No virus found in this incoming message.
Checked by AVG Anti-Virus.
Version: 7.0.344 / Virus Database: 267.11.13/126 - Release Date: 10/9/2005

--
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.344 / Virus Database: 267.11.14/127 - Release Date: 10/10/2005

