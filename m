Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263316AbVGOPJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbVGOPJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 11:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbVGOPJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 11:09:55 -0400
Received: from web25802.mail.ukl.yahoo.com ([217.12.10.187]:49055 "HELO
	web25802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263316AbVGOPJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 11:09:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wzp6L2/isskFQhkXm/LsZqSS3eXGfOfQkA2rGvI2GXI1kLPCgcAaOYcKE+SCfxWtj57MDhG5IC86Nu9ZlsAbg8GSbZfui/r9nwWuptpoRJAmd+tTYApPNBcTZdl86R/gW1uzDxpJFRiqGo89ZslzIoCaehxp9YY83bvbb4wnSws=  ;
Message-ID: <20050715150935.3023.qmail@web25802.mail.ukl.yahoo.com>
Date: Fri, 15 Jul 2005 17:09:34 +0200 (CEST)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: console remains blanked
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1121437536.5963.24.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

 --- Benjamin Herrenschmidt <benh@kernel.crashing.org>
escribió:
> Yes. We discussed that with Linus back then. The
> problem is that the
> printk subsystem tend to abuse calling low level
> drivers at interrupt
> time, and in the case of blanking/unblanking, this
> can be a problem.
> Radeonfb for example relies on beeing able to
> schedule() at
> blank/unblank time.

Ok.

> If this "feature" is really important, maybe the
> best is to trigger the
> workqueue and do the ublank from there.

It looks like I'm the only one concerned, so don't
worry. I'll workaround it.

Thanks for your feedback.

Cheers,
Albert




		
______________________________________________ 
Renovamos el Correo Yahoo! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
