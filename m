Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285413AbRLNQvz>; Fri, 14 Dec 2001 11:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285412AbRLNQvp>; Fri, 14 Dec 2001 11:51:45 -0500
Received: from t2.redhat.com ([199.183.24.243]:28915 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285410AbRLNQv1>; Fri, 14 Dec 2001 11:51:27 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <0ddd01c184b3$ce15c470$5601010a@prefect> 
In-Reply-To: <0ddd01c184b3$ce15c470$5601010a@prefect>  <066801c183f2$53f90ec0$5601010a@prefect> <20011213160007.D998D23CCB@persephone.dmz.logatique.fr> <25867.1008323156@redhat.com> 
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "Thomas Capricelli" <orzel@kde.org>, linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Dec 2001 16:51:15 +0000
Message-ID: <13988.1008348675@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


brad@ltc.com said:
>  That sounds nice, but I cannot imagine how much trouble it would be
> to implement.

Adding the pages to the page cache on read_inode() is fairly simple. Hacking 
the kernel so that readpage() can provide its own page less so.

>  Actually, I've used that patch on a system that had a cramfs/xip and
> a jffs partition on the same flash chip where the kernel was running
> xip out of flash.  :-) 

S'OK if you have the right type of flash chips, I suppose :)

--
dwmw2


