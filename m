Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264117AbUFBUhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUFBUhf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbUFBUhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:37:34 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:34276 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264117AbUFBUhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:37:32 -0400
Message-Id: <200406022037.i52KbLuN004947@eeyore.valparaiso.cl>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
cc: linux-kernel@vger.kernel.org, "Al Piszcz" <apiszcz@solarrain.com>
Subject: Re: How come dd if=/dev/zero of=/nfs/dev/null does not send packets over the network? 
In-Reply-To: Message from "Piszcz, Justin Michael" <justin.piszcz@mitretek.org> 
   of "Wed, 02 Jun 2004 08:04:06 -0400." <5D3C2276FD64424297729EB733ED1F7606243695@email1.mitretek.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Wed, 02 Jun 2004 16:37:21 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Piszcz, Justin Michael" <justin.piszcz@mitretek.org> said:

[...]

> Instead it treats it as a local block device?

Because only the _description_ (inode for device, etc) for /nfs/dev/null
are gotten over the net, the actual _device_ is local.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
