Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTJUJii (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 05:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbTJUJib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 05:38:31 -0400
Received: from mesa.unizar.es ([155.210.11.66]:47525 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S262930AbTJUJhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 05:37:50 -0400
Date: Tue, 21 Oct 2003 11:37:20 +0200
From: Jorge Bernal <koke@sindominio.net>
To: Andrew Morton <akpm@osdl.org>
Cc: ranty@debian.org, hunold@convergence.de, marcel@holtmann.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Proposal to remove workqueue usage from request_firmware_async()
Message-ID: <20031021093720.GA11101@tuxland.servebeer.com>
References: <20031020235355.GA3068@ranty.pantax.net> <20031020170804.2117d9ca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020170804.2117d9ca.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 05:08:04PM -0700, Andrew Morton wrote:
> 	daemonize("firmware/%s", "fw_work->name);
daemonize("firmware/%s", fw_work->name);

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
"Dios es real, a no ser que sea declarado como entero"

Jorge Bernal "Koke" http://sindominio.net/~koke/
Jabber-ID: koke@zgzjabber.ath.cx
<koke@sindominio.net> || <kokecillo@eresmas.com>
.: www.augustux.org   ::	pulsar.gotdns.org	 :.
