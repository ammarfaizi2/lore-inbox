Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276451AbRJYV56>; Thu, 25 Oct 2001 17:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbRJYV5s>; Thu, 25 Oct 2001 17:57:48 -0400
Received: from AMontpellier-201-1-4-3.abo.wanadoo.fr ([217.128.205.3]:30219
	"EHLO awak") by vger.kernel.org with ESMTP id <S276451AbRJYV5q> convert rfc822-to-8bit;
	Thu, 25 Oct 2001 17:57:46 -0400
Subject: Re: [RFC] New Driver Model for 2.5
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
In-Reply-To: <E15wjqP-0004kD-00@the-village.bc.nu>
In-Reply-To: <E15wjqP-0004kD-00@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16.99+cvs.2001.10.22.19.14 (Preview Release)
Date: 25 Oct 2001 23:52:01 +0200
Message-Id: <1004046722.9892.120.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le jeu 25-10-2001 à 14:42, Alan Cox a écrit :
> > If you have a acpi deamon that decides to make the machine go to sleep
> > while burning a CD, that's nothign to do with the kernel at all.
> 
> One job kernel drivers have is to say "I can't safely sleep at this moment"
> Even windows/XP beta gets this right.

The other solution (let cdrecord tell I-dunno-how the PM daemon that
it's doing something "important") is IMHO better: the PM daemon could
judge if it should honor the suspend request depending on its priority
(inactivity, power button or low battery) and the running "important"
jobs.

	Xav

