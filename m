Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVAZNpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVAZNpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVAZNpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:45:13 -0500
Received: from relay.unizar.es ([155.210.11.72]:47748 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S262296AbVAZNpD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:45:03 -0500
From: Jorge Bernal <koke@sindominio.net>
To: Colin Leroy <colin@colino.net>
Subject: Re: [PATCH] therm_adt746x: smooth fan
Date: Wed, 26 Jan 2005 14:44:07 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200501260912.27216.koke@amedias.org> <20050126140319.05d7264b@pirandello>
In-Reply-To: <20050126140319.05d7264b@pirandello>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501261444.07339.koke@sindominio.net>
X-Mail-Scanned: Criba 2.0 + Clamd en Unizar
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Miércoles 26 Enero 2005 14:03, Colin Leroy escribió:
> > This patchs allows a smoother fan speed switching with therm_adt746x.
> > Instead of setting 0 or 128, it scales speed according to temperature.
>
> Thanks, but you'd have saved some of your time if you had checked
> 2.6.10: I implemented such a system, it's in since 2.6.10 :)
>

doh! no problem at all, it didn't took me much time.

I guess I'll try in 2.6.11, since hibernation does not work very well with 
2.6.10 in my ibook.

> > It would be even better if I'd have more precise temp data, but I'm
> > not sure if it's even supported by the chip.
>
> It's not possible, iirc.
>
> Also, it's better to Cc: the maintainer of a module when submitting
> patches. I'm not subscribed to lkml currently, and would have missed
> your mail if I didn't get it from a friend.

I'll note for the next time, thanks :)

-- 
Jorge Bernal "Koke"
Personal:  koke@sindominio.net
Jabber:  koke@zgzjabber.ath.cx
Blog:  http://www.amedias.org/koke/

"Computer Science is no more about computers than astronomy is about 
telescopes." - Edsger Dijkstra
