Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272889AbRISXOt>; Wed, 19 Sep 2001 19:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274256AbRISXOj>; Wed, 19 Sep 2001 19:14:39 -0400
Received: from anime.net ([63.172.78.150]:50183 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S272889AbRISXOg>;
	Wed, 19 Sep 2001 19:14:36 -0400
Date: Wed, 19 Sep 2001 16:14:52 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: John Alvord <jalvo@mbay.net>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Arjan van de Ven <arjanv@redhat.com>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <a68iqtovbjt57qqqv1mkrmdsujhu2k3ebu@4ax.com>
Message-ID: <Pine.LNX.4.30.0109191611010.30343-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, John Alvord wrote:
> >Until we have a straight answer what the hell this bit does, its a very
> >bad idea to put it into *production kernel*.
> Of course the BIOS versions made exactly that change...

1) We dont know if all "fixed" BIOS versions do it
2) We dont know if all motherboards do it
3) We dont have enough data points to determine if this is a "real fix" yet.
4) We dont know if they do it under all circumstances
   (eg do they read SPD and set it in some situations and not others)
   It may even be CPU rev specific.

IMHO its *FAR* too premature to be rolling this into production kernels
based on the scant evidence we have so far.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

