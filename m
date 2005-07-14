Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVGNKSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVGNKSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbVGNKSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:18:09 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:31866 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261479AbVGNKSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:18:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VCwznV9wTHwAn9ZzqmjOIqlKlY2RhtfQvea8tpXHBE3sC5HXrbmtVk7mlMJhVyMF9blPnJ/AoO/XHuRVp7mr6Kfg0xLTSOE3EMCt3xReGSKWRxlJKY7cQ22jDHlAkCcNUzUwqmoqflJnQ6NHoh8nvmGCfjmH4T8X6KpN9noaveA=  ;
Message-ID: <20050714101807.74323.qmail@web25805.mail.ukl.yahoo.com>
Date: Thu, 14 Jul 2005 12:18:07 +0200 (CEST)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: console remains blanked
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507141134060.18072@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 --- Jan Engelhardt <jengelh@linux01.gwdg.de>
escribió:
> The console is unblanked when you hit a key (or
> probably move a mouse too), 
> not when some application outputs something on
> stdout/stderr/etc.

Before 2.6.12-rc2, the console was unblanked by just
writing to the console.
For keyboardless and mouseless systems (which is my
case, embedded) this new behaviour is a bit annoying.

> Which kernel versions have this patch? I'm on
> 2.6.13-rc1 and have no problems 
> with unblanking.

I have this problem since 2.6.12-rc2.
If I add back the patch hunk specified in my original
message, the blanking behaviour changes to that
present in pre-2.6.12-rc2 kernels.

I just would like to know if this new behaviour is
just intentional and makes sense to everyone (except
me :-)

Thanks for your feedback,
Albert



		
______________________________________________ 
Renovamos el Correo Yahoo! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
