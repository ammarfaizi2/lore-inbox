Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130434AbRCLOlX>; Mon, 12 Mar 2001 09:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130441AbRCLOlO>; Mon, 12 Mar 2001 09:41:14 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:54277 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S130434AbRCLOlK>;
	Mon, 12 Mar 2001 09:41:10 -0500
Date: Mon, 12 Mar 2001 15:40:10 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Rama Krishna Mandava <ramakrishna.mandava@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: memcpy
Message-ID: <20010312154010.A8760@se1.cogenit.fr>
In-Reply-To: <01031220481904.06445@elinux.wipsys>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <01031220481904.06445@elinux.wipsys>; from ramakrishna.mandava@wipro.com on Mon, Mar 12, 2001 at 08:44:43PM +0530
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rama Krishna Mandava <ramakrishna.mandava@wipro.com> écrit :
[...]
>            can memcpy ,memset functions be used in  drivermodules code  of
> linux ? if so header file string.h is enough to be included?

Take a look at <kernel_tree>/include/linux/string.h. You just need to:
#include <linux/string.h>

-- 
Ueimor
