Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUDSJON (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 05:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbUDSJON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 05:14:13 -0400
Received: from mesa.unizar.es ([155.210.11.66]:24292 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S263979AbUDSJOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 05:14:08 -0400
From: "Jorge Bernal (Koke)" <koke_lkml@amedias.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 pts problem
Date: Mon, 19 Apr 2004 11:13:49 +0200
User-Agent: KMail/1.6.1
References: <1082353929.850.126.camel@cube>
In-Reply-To: <1082353929.850.126.camel@cube>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404191113.50483.koke_lkml@amedias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Lunes, 19 de Abril de 2004 07:52, Albert Cahalan wrote:
> >> As you see, pts is just growing, not using the old used numbers.
> >
> > The implementation was changed intentionally to make
> > it that way. The numbers will only be recycled once we
> > go over the max number of psuedoterminals, I think..
>
> You can also recycle the numbers by rebooting.
> That's what I do. :-/
>

and what about making that configurable.

I mean putting a config option to select between "recyclable" and 
"non-recyclable" pts numbers. Or maybe via /proc

> (I can't be spending 10% of my disk on a giant wtmp
> file. Also, I use the tty names for xterm titles now.
> If they get too big, the GNOME taskbar button titles
> get truncated.)
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
