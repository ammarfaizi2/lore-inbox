Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268502AbRG3LUX>; Mon, 30 Jul 2001 07:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268503AbRG3LUN>; Mon, 30 Jul 2001 07:20:13 -0400
Received: from aravis.cur-archamps.fr ([195.202.0.99]:21765 "EHLO
	aravis.cur-archamps.fr") by vger.kernel.org with ESMTP
	id <S268502AbRG3LUG>; Mon, 30 Jul 2001 07:20:06 -0400
Date: Mon, 30 Jul 2001 13:20:13 +0200
From: Thierry Laronde <thierry@cri74.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Debian boot mailing list <debian-boot@lists.debian.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PCI] building PCI IDs/drivers DB from Linux kernel sources
Message-ID: <20010730132013.C25441@pc04.cri.cur-archamps.fr>
In-Reply-To: <20010730113319.A24939@pc04.cri.cur-archamps.fr> <22966.996491181@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <22966.996491181@ocs3.ocs-net>; from kaos@ocs.com.au on Mon, Jul 30, 2001 at 09:06:21PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 09:06:21PM +1000, Keith Owens wrote:
> On Mon, 30 Jul 2001 11:33:19 +0200, 
> Thierry Laronde <thierry@cri74.org> wrote:
> >In order to allow a kind of light detection of hardware to be use during
> >installation, I wanted to build a database (for PCI: I start with the
> >easiest...) with the following format:
> >
> >CLASS_ID	VENDOR_ID	DEVICE_ID	driver_name
> 
> depmod already builds /lib/modules/`uname -r`/modules.pcimap containing
> all the data required for PCI identification.  Before you reinvent too
> many wheels, see the hotplug project,
> http://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel

Thanks for the pointer. I will give a look.
-- 
Thierry LARONDE, Centre de Ressources Informatiques, Archamps - France
http://www.cri74.org/
