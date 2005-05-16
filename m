Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVEPML5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVEPML5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVEPML4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:11:56 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:31847 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261565AbVEPMLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:11:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IC6rhZ/N/jfYFpQSKLmUa0j0l1P4FWiB2u5QSNDLC97yqOF3TJ69gHjuHC+tqtZUADhWqBERJNOpRH0H/AfqD0nZm6bvn0/iXv/zVCgipJb1UaVQtAMGvReocLZp7DUlk/VuRx4nFbaxftQnuZqo2MqbwtJdwid0SePRaILm+uM=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Danny ter Haar <dth@picard.cistron.nl>
Subject: Re: 2.6.12-rc4-mm2
Date: Mon, 16 May 2005 16:15:49 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20050516021302.13bd285a.akpm@osdl.org> <200505161517.40802.adobriyan@gmail.com> <d6a0oj$akh$1@news.cistron.nl>
In-Reply-To: <d6a0oj$akh$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505161615.50884.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 May 2005 15:38, Danny ter Haar wrote:
> Alexey Dobriyan  <adobriyan@gmail.com> wrote:
> >Does this help?
> >--- linux-2.6.12-rc4-mm2/include/acpi/achware.h
> >+++ linux-2.6.12-rc4-mm2-acpi/include/acpi/achware.h

> Nope, (unfortunatly)

Please, try this.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- linux-2.6.12-rc4-mm2/include/acpi/achware.h	2005-05-16 14:24:02.000000000 +0400
+++ linux-2.6.12-rc4-mm2-acpi/include/acpi/achware.h	2005-05-16 16:05:41.000000000 +0400
@@ -44,6 +44,8 @@
 #ifndef __ACHWARE_H__
 #define __ACHWARE_H__
 
+struct acpi_gpe_xrupt_info;
+struct acpi_gpe_block_info;
 
 /* PM Timer ticks per second (HZ) */
 
