Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132914AbRD1O2b>; Sat, 28 Apr 2001 10:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132934AbRD1O2V>; Sat, 28 Apr 2001 10:28:21 -0400
Received: from jalon.able.es ([212.97.163.2]:4833 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132914AbRD1O2M>;
	Sat, 28 Apr 2001 10:28:12 -0400
Date: Sat, 28 Apr 2001 16:28:03 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Wakko Warner <wakko@animx.eu.org>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010428162803.C1062@werewolf.able.es>
In-Reply-To: <20010428093722.A17218@animx.eu.org> <200104281411.QAA04406@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200104281411.QAA04406@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Sat, Apr 28, 2001 at 16:11:47 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.28 Rogier Wolff wrote:
> 
> I've ALWAYS said that it's a rule-of-thumb. This means that if you
> have a good argument to do it differently, you should surely do so!
> 

I'm not so sure it's only a 'rule of thumb'. Do not know the state of
paging in just released 2.4.4, but in previuos kernel, a page that was
paged-out, reserves its place in swap even if it is paged-in again, so
once you have paged-out all your ram at least once, you can't get any
more memory, even if swap is 'empty'.

Now that macs leave out that kind of swap (MacOS classic), linux takes it.
At least macos does not allow you to set vm to less than your physical mem.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.4 #1 SMP Sat Apr 28 11:45:02 CEST 2001 i686

