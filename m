Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbULaOYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbULaOYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 09:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbULaOYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 09:24:10 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:16354 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262061AbULaOYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 09:24:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ar/VwqcdnQIucfXnnSgg/wTWOHlSZxmLlAm/dWPSATR08N9imWHB6GAvg73UtMIQSjyOod7tAmt1e/itVa8QetJD5ngBKRJ1qvWyQeXoc+Dzbm5Qoem9QeokHuywn1U4Js229UC94m3uWgjShUP8mKxOBLsIOqG5jVdfcr4EcVA=
Message-ID: <2cd57c90041231062438c2cab9@mail.gmail.com>
Date: Fri, 31 Dec 2004 22:24:06 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] /proc/sys/kernel/bootloader_type
Cc: Andrew Morton <akpm@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org, SYSLINUX@zytor.com
In-Reply-To: <1104487954.5402.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41D34E3A.3090708@zytor.com>
	 <20041231013443.313a3320.akpm@osdl.org>
	 <1104487954.5402.20.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004 11:12:34 +0100, Arjan van de Ven
<arjan@infradead.org> wrote:
> On Fri, 2004-12-31 at 01:34 -0800, Andrew Morton wrote:
> > "H. Peter Anvin" <hpa@zytor.com> wrote:
> > >
> > > This patch exports to userspace the boot loader ID which has been
> > >  exported by (b)zImage boot loaders since boot protocol version 2.
> >
> > Why does userspace need to know this?
> 
> so that update tools that update kernels from vendors know which
> bootloader file they need to update; eg right now those tools do all
> kinds of hairy heuristics to find out if it's grub or lilo or .. that
> installed the kernel. Those heuristics are fragile in the presence of
> more than one bootloader (which isn't that uncommon in OS upgrade
> situations).
> 

This boot loader ID doesn't help much for system upgrade. The running
kernel may boot from removable drive.


-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
