Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUC3XE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUC3XCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:02:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:19096 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261597AbUC3W7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:59:14 -0500
Subject: Re: booting 2.6.4 from OpenFirmware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Schaffner <schaffner@gmx.li>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <321B041D-8298-11D8-AC61-0003931E0B62@gmx.li>
References: <321B041D-8298-11D8-AC61-0003931E0B62@gmx.li>
Content-Type: text/plain
Message-Id: <1080687527.1198.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Mar 2004 08:58:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 08:18, Martin Schaffner wrote:
> Hi,
> 
> I try to boot linux-2.6.4 from OpenFirmware on my Apple iBook2 (dual 
> USB). I'm using the image named "vmlinux.elf-pmac". While linux-2.4.25 
> boots fine, linux-2.6.4 doesn't without the following modifications:
> 
> http://membres.lycos.fr/schaffner/howto/linux26-boot-of.txt
> 
> (I found this procedure by trial and error, by mixing stuff from 2.4 
> into the build of 2.6.)
> 
> If I try to boot the stock kernel, OpenFirmware tells me "Claim 
> failed", and returns to the command prompt.
> 
> Does anybody have an idea what is the cause of this?

That's strange, I do such netbooting everyday on a wide range of
machines without trouble. Are you using some kind of cross compiler ?
Maybe there are some issues with cross compiling of the boot wrapper...

Ben.


