Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268904AbTBZUWT>; Wed, 26 Feb 2003 15:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268914AbTBZUWT>; Wed, 26 Feb 2003 15:22:19 -0500
Received: from fmr02.intel.com ([192.55.52.25]:49647 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268904AbTBZUWS> convert rfc822-to-8bit; Wed, 26 Feb 2003 15:22:18 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C780A7D596C@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Dave Airlie'" <airlied@linux.ie>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: holding kernel semaphores while in userspace ...
Date: Wed, 26 Feb 2003 12:32:26 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm doing stupid and evil .. and should I just be happy with my SYSV
> semaphores or just use futexes (do these work acroess processes??)

They do - I also think RH is porting the futex stuff for NPTL to 2.4 for
their betas, so you might want to check it out (disclaimer: I read this
somewhere in the NPTL mailing list ... go figure :)

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)


