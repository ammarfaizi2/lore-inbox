Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132526AbRD2K0O>; Sun, 29 Apr 2001 06:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbRD2K0E>; Sun, 29 Apr 2001 06:26:04 -0400
Received: from jalon.able.es ([212.97.163.2]:26499 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132526AbRD2KZx>;
	Sun, 29 Apr 2001 06:25:53 -0400
Date: Sun, 29 Apr 2001 12:25:46 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "Steve 'Denali' McKnelly" <denali@sunflower.com>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Message-ID: <20010429122546.A1419@werewolf.able.es>
In-Reply-To: <20010428202225.D11994@emma1.emma.line.org> <PGEDKPCOHCLFJBPJPLNMCEDICMAA.denali@sunflower.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <PGEDKPCOHCLFJBPJPLNMCEDICMAA.denali@sunflower.com>; from denali@sunflower.com on Sun, Apr 29, 2001 at 11:36:55 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.29 Steve 'Denali' McKnelly wrote:
>              Command found on device queue
> aic7xxx_abort returns 8194
> 

I have seen blaming for this error to aic7xxx new driver prior to version
6.1.11. It was included in the 2.4.3-ac series, but its has not got into
main 2.4.4 (there is still 6.1.5). Everything needs its time.

Grab the updated patch from people.freebsd.org/~gibbs/linux.

BTW (Alan?) new version is 6.1.12 (just patched 2.4.4 after offset
engineering and works fine).
Candidate for 2.4.4-ac1 or 2.4.5-pre1 ?

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.4 #1 SMP Sat Apr 28 11:45:02 CEST 2001 i686

