Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWESBvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWESBvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWESBvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:51:22 -0400
Received: from e-nvb.com ([69.27.17.200]:36536 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S932187AbWESBvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:51:22 -0400
Subject: Re: Invalid module format?
From: Arjan van de Ven <arjan@infradead.org>
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B321D@chicken.machinevisionproducts.com>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B321D@chicken.machinevisionproducts.com>
Content-Type: text/plain
Date: Fri, 19 May 2006 03:50:39 +0200
Message-Id: <1148003459.2994.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 07:01 -0700, Brian D. McGrew wrote:
> I have two device drivers for two separate PCI cards.
> 
> Using the 2.6.15.6 I can compile and insert both of these drivers.
> 
> I copy my sources to my 2.6.16.16 tree and recompile them.  One driver
> inserts just fine (and works) and the other gives me this:
> 
> FATAL: Error inserting ibb
> (/lib/modules/2.6.16.16/kernel/drivers/mvp/ibb.ko): Invalid module
> format
> 
> The same source file between both kernels and I get no errors at compile
> time.

you forgot to
1) look into dmesg and give us the information that gets printed there
   when modprobe returns this error
2) point to the source of the driver



