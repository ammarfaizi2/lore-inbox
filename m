Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276069AbRI1OOf>; Fri, 28 Sep 2001 10:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276070AbRI1OOZ>; Fri, 28 Sep 2001 10:14:25 -0400
Received: from t2.redhat.com ([199.183.24.243]:41466 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S276069AbRI1OOI>; Fri, 28 Sep 2001 10:14:08 -0400
Message-ID: <3BB485C1.4FFAD808@redhat.com>
Date: Fri, 28 Sep 2001 15:14:25 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Caujolle-Bert <segfault@club-internet.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com> <3BB48494.404F15A8@club-internet.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Caujolle-Bert wrote:

> > Hardware drivers
> > ----------------
> [...]
> > PCTel           - winmodem driver
> 
>         This one is not really 100% binary only, it use
> an modified version of serial.c kernel driver. Of course
> it's freely available.

That I would call an obvious GPL violation... no discussion
about vague "interfaces", if you directly link serial.c 
(even modified) into a non-GPL .o file that's obvious....
