Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKFK7X>; Mon, 6 Nov 2000 05:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbQKFK7N>; Mon, 6 Nov 2000 05:59:13 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:17658 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129044AbQKFK7G>;
	Mon, 6 Nov 2000 05:59:06 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <2214.973473372@kao2.melbourne.sgi.com> 
In-Reply-To: <2214.973473372@kao2.melbourne.sgi.com> 
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0-test10-pre6 remove get_module_symbol MTD/DRM/AGP 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 10:58:31 +0000
Message-ID: <22235.973508311@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  Any comments before it goes to Linus? 

I'd prefer to update MTD separately if and when the inter_module_xxx 
support gets into both 2.2 and 2.4. 

Could you first provide a patch which adds this support - when it's merged 
into both 2.2 and 2.4 I'll update the MTD code without needing to keep 
backwards-compatibility, and then we can remove get_module_symbol() altogether.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
