Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262263AbRETWwT>; Sun, 20 May 2001 18:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262265AbRETWwJ>; Sun, 20 May 2001 18:52:09 -0400
Received: from t2.redhat.com ([199.183.24.243]:9717 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262263AbRETWwA>; Sun, 20 May 2001 18:52:00 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010520165952.A9622@devserv.devel.redhat.com> 
In-Reply-To: <20010520165952.A9622@devserv.devel.redhat.com>  <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com> <18686.990380851@redhat.com> <20010520164700.H4488@thyrsus.com> 
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 May 2001 23:51:56 +0100
Message-ID: <25499.990399116@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


arjanv@redhat.com said:
> Maybe it would be possible to separate "hard" dependencies like the
> current system has with the "soft" ones one needs for entry-level
> configtools.

Actually, the current system has both types. As well as the "hard" 
dependencies, we also have stuff like CONFIG_PARTITION_ADVANCED, 
CONFIG_CPU_ADVANCED, CONFIG_FBCON_ADVANCED, CONFIG_MTD_DOCPROBE_ADVANCED, 
etc. CONFIG_EXPERIMENTAL serves a very similar purpose, too.

These things have already been set up in the way that developers prefer it. 

CML2 allows us to be more flexible than we were before, and that can be a
good thing when used in moderation. But please, for the sake of the sanity
of all concerned, do things one at a time. Provide for merging into 2.5 a set 
of rules which reproduce the existing CML1 behaviour in this respect. 

Eric, if you want to make further changes later to introduce new 'modes' for
kernel configuration, that's an entirely separate issue. Please don't
confuse the issue by trying to do it at the same time as introducing CML2.

CONFIG_AUNT_TILLIE does not require CML2.
CML2 does not require CONFIG_AUNT_TILLIE.

Let's not talk about CONFIG_AUNT_TILLIE any more, or change the existing
behaviour of config options to make that the default, until we've settled
the discussion about CML2.

--
dwmw2


