Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUDAAOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 19:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbUDAAOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 19:14:51 -0500
Received: from imap.gmx.net ([213.165.64.20]:22442 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262113AbUDAAOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 19:14:49 -0500
X-Authenticated: #1892127
Mime-Version: 1.0 (Apple Message framework v613)
In-Reply-To: <1080687527.1198.48.camel@gaston>
References: <321B041D-8298-11D8-AC61-0003931E0B62@gmx.li> <1080687527.1198.48.camel@gaston>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <555BCB50-837A-11D8-8BC8-0003931E0B62@gmx.li>
Content-Transfer-Encoding: 7bit
From: Martin Schaffner <schaffner@gmx.li>
Subject: Re: booting 2.6.4 from OpenFirmware
Date: Thu, 1 Apr 2004 02:17:24 +0100
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30.03.2004, at 23:58, Benjamin Herrenschmidt wrote:

> On Wed, 2004-03-31 at 08:18, Martin Schaffner wrote:
>> Hi,
>>
>> I try to boot linux-2.6.4 from OpenFirmware on my Apple iBook2 (dual
>> USB). I'm using the image named "vmlinux.elf-pmac". While linux-2.4.25
>> boots fine, linux-2.6.4 doesn't  [...]
>>
>> If I try to boot the stock kernel, OpenFirmware tells me "Claim
>> failed", and returns to the command prompt.
>
> That's strange, I do such netbooting everyday on a wide range of
> machines without trouble. Are you using some kind of cross compiler ?
> Maybe there are some issues with cross compiling of the boot wrapper...

I WAS cross-compiling, but the problem persists when compiling 
natively. I don't net-boot but load the image from a HFS+ partition. I 
can't boot

http://membres.lycos.fr/schaffner/vmlinux.orig

which is a compilation of linux-2.6.4 with

http://membres.lycos.fr/schaffner/.config

I can, however, boot

http://membres.lycos.fr/schaffner/vmlinux.patched

which is the same after the following patch:

http://membres.lycos.fr/schaffner/boot-of-works.patch

Maybe the problem is specific to the model of the machine?

Thanks,

Martin

