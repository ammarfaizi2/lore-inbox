Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbRF1EGy>; Thu, 28 Jun 2001 00:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265516AbRF1EGo>; Thu, 28 Jun 2001 00:06:44 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:40162 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265517AbRF1EGg>;
	Thu, 28 Jun 2001 00:06:36 -0400
Message-ID: <3B3AAD71.84FC36AD@mandrakesoft.com>
Date: Thu, 28 Jun 2001 00:07:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: elenstev@mesatop.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.4.6-pre6 fix drivers/net/Config.in error
In-Reply-To: <01062721090303.01154@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> -   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
> +   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI $CONFIG_PCI

See the "EISA" and "VLB" parts in there?  EISA != PCI

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
