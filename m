Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270656AbTGNPRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270644AbTGNPQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:16:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38338
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270598AbTGNPNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:13:31 -0400
Subject: Re: mmap method implementation question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <7A25937D23A1E64C8E93CB4A50509C2A0179B6D2@stca204a.bus.sc.rolm.com>
References: <7A25937D23A1E64C8E93CB4A50509C2A0179B6D2@stca204a.bus.sc.rolm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058196344.561.80.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 16:25:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 13:49, Bloch, Jack wrote:
> I jave a device driver which was originaly created for a Kernel 2.4.18-3. It
> has an mmap method which uses a call to remap_page_range. In this call, I
> pass the in the logical start address, the physical address, the size and
> protection mappings. I have upgraded the Kernel to a 2.4.20-8 and now my
> remap_page_range call does not compile. It requires me to pass the vma
> structure as a first parameter. What changed? Whys is this necessary?

You should ask Red Hat. 2.4.20 doesn't have this property.

