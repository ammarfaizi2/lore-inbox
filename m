Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVALONZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVALONZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 09:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVALONZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 09:13:25 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:28588 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261190AbVALONV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 09:13:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=j3E653bpKSZ88d6lEoxGptCKpnIpUCpdlDYT8AWIY5PWOniRW2yT8iiu85vnAP3C93uzRLStIICPYHGh+tR6nEm9K5TVufw0h48xtScDhrV60JgjgrZrldWKTOWbbffdRGjMLGUHBr6+fsBEtW7cgk0xCXopR23RdKb4n8AYVK4=
Message-ID: <d120d500050112061348443e1f@mail.gmail.com>
Date: Wed, 12 Jan 2005 09:13:21 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Brice.Goglin@ens-lyon.org
Subject: Re: Linux 2.6.11-rc1
Cc: Tino Keitel <tino.keitel@gmx.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E4F010.9090305@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
	 <41E4DEBB.90606@ens-lyon.fr> <20050112092042.GA27528@dose.home.local>
	 <41E4F010.9090305@ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005 10:38:24 +0100, Brice Goglin
<Brice.Goglin@ens-lyon.fr> wrote:
> >>puligny:~# setkeycodes e023 150 e01e 155 e01a 217 e01f 157
> >>KDSETKEYCODE: No such device
> >>failed to set scancode a3 to keycode 150
> >
> >
> > Did this work for you with 2.6.10? I currently use 2.6.9-mm1 and I get
> > the same error on Debian Sid.
> >
> > Regards,
> > Tino
> 
> Yes, works on 2.6.10 and even 2.6.10-mm3.
> 

Please try the patch from here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110430679525030&w=2

Vojtech said he'd push it and some more stuff to Linus...

-- 
Dmitry
