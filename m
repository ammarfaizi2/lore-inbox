Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284488AbRLMR67>; Thu, 13 Dec 2001 12:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284491AbRLMR6t>; Thu, 13 Dec 2001 12:58:49 -0500
Received: from zeus.kernel.org ([204.152.189.113]:52201 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S284488AbRLMR6k>;
	Thu, 13 Dec 2001 12:58:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011213163912.5741223CCD@persephone.dmz.logatique.fr> 
In-Reply-To: <20011213163912.5741223CCD@persephone.dmz.logatique.fr>  <20011213160007.D998D23CCB@persephone.dmz.logatique.fr> <066801c183f2$53f90ec0$5601010a@prefect> 
To: Thomas Capricelli <orzel@kde.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Dec 2001 17:49:00 +0000
Message-ID: <1116.1008265740@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


orzel@kde.org said:
>  Does it mean that NONE of the existing embedded linux is able to use
> a ROM  directly as a filesystem ?? (either root fs or not) 

Out of the box, no. XIP isn't that interesting. Most boxes have flash, and 
flash is more expensive than RAM - so compression is more useful than XIP 
in many cases. Obviously the two are mutually exclusive.

Writing to an XIP filesystem is fairly hard too.

--
dwmw2


