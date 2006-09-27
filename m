Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965440AbWI0Htu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965440AbWI0Htu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965442AbWI0Htu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:49:50 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:39120 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S965440AbWI0Htt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:49:49 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
To: Len Brown <lenb@kernel.org>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Wed, 27 Sep 2006 10:50:02 +0300
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>,
       Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <20060926135659.GA3685@jnb.gelma.net> <20060926221400.5da1b796.akpm@osdl.org> <200609270204.38970.len.brown@intel.com>
In-Reply-To: <200609270204.38970.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609271050.03904.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
27 Eyl 2006 Çar 09:04 tarihinde, Len Brown şunları yazmıştı: 
[...]
> > > Will sony_acpi ever make it to the mainline? Its very useful for new
> > > Vaio models.
>
> Nope, not as it is.  Useful != supportable.
>
> 1. It must not create any files under /proc/acpi
>     This is creating a machine-specific API, which
>     is exactly what we don't want  Nobody can maintain
>     50 machine specific APIs.
>
>     These objects must appear generic and under sysfs
>     as if acpi were not involved in providing them.
>
> 2. its source code shall not live in drivers/acpi
>     it is not part of the ACPI implementation after all --
>     it is a platform specific driver.

Is there a such example code under kernel now, so one could look at it and fix 
sony_acpi driver.

Regards,
ismail

-- 
They that can give up essential liberty to obtain a little temporary safety 
deserve neither liberty nor safety.
-- Benjamin Franklin
