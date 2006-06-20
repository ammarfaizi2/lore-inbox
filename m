Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWFTOVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWFTOVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWFTOVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:21:36 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:5595 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751067AbWFTOVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:21:35 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [PATCH 1/1] New Framebuffer for Intel based Macs
To: Edgar Hucek <hostmaster@ed-soft.at>, LKML <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Tue, 20 Jun 2006 16:21:08 +0200
References: <6pOCE-1Dv-39@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1Fsh6K-0000mJ-L7@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Hucek <hostmaster@ed-soft.at> wrote:

> +config FB_IMAC
> +        bool "Intel Based Macs FB"
> +        depends on (FB = y) && X86
> +        select FB_CFB_FILLRECT
> +        select FB_CFB_COPYAREA
> +        select FB_CFB_IMAGEBLIT
> +        help
> +          This is the frame buffer device driver for the Inel Based Mac's

1) Speling error: Inel
2) Isn't there a macintosch CONFIG option you can depend on?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
