Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276422AbRI2DKX>; Fri, 28 Sep 2001 23:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRI2DKO>; Fri, 28 Sep 2001 23:10:14 -0400
Received: from codepoet.org ([166.70.14.212]:36711 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S276422AbRI2DJ4>;
	Fri, 28 Sep 2001 23:09:56 -0400
Date: Fri, 28 Sep 2001 21:10:27 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac17
Message-ID: <20010928211027.A10265@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010929004412.A1335@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010929004412.A1335@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux 2.4.9-ac10-rmk1, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 29, 2001 at 12:44:12AM +0100, Alan Cox wrote:
> 
> 2.4.9-ac17
> o	Next batch of MODULE_LICENSE tags		(Arjan van de Ven)


gcc -D__KERNEL__ -I/home/andersen/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i386    -c -o aha1740.o aha1740.c
aha1740.c:617: parse error before string constant
aha1740.c:617: warning: type defaults to `int' in declaration of `MODULE_LICENSE'
aha1740.c:617: warning: function declaration isn't a prototype
aha1740.c:617: warning: data definition has no type or storage class
make[4]: *** [aha1740.o] Error 1

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
