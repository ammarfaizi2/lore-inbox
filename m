Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280419AbRKGKab>; Wed, 7 Nov 2001 05:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280435AbRKGKaV>; Wed, 7 Nov 2001 05:30:21 -0500
Received: from t2.redhat.com ([199.183.24.243]:65021 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S280419AbRKGKaJ>; Wed, 7 Nov 2001 05:30:09 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011107104405.A3168@emeraude.kwisatz.net> 
In-Reply-To: <20011107104405.A3168@emeraude.kwisatz.net>  <20011105231759.02B541195E@a.mx.spoiled.org> <200111061645.RAA02115@fandango.cs.unitn.it> 
To: stephane@tuxfinder.org
Cc: Massimo Dal Zotto <dz@cs.unitn.it>, LKLM <linux-kernel@vger.kernel.org>,
        "Marcel J. E. Mol" <marcel@mesa.nl>,
        Juri Haberland <juri@koschikode.com>
Subject: Re: [PATCH] SMM BIOS on Dell i8100 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 10:29:05 +0000
Message-ID: <14756.1005128945@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


stephane@tuxfinder.org said:
>  Without that, I get as much zombies processes as I have pressed the
> volume buttons :-) I know system() is not great, but as security is
> not a problem here...

signal(SIGCHLD, SIG_IGN);


--
dwmw2


