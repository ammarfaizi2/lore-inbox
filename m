Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265810AbRFYACX>; Sun, 24 Jun 2001 20:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265811AbRFYACN>; Sun, 24 Jun 2001 20:02:13 -0400
Received: from jalon.able.es ([212.97.163.2]:61069 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S265810AbRFYACB>;
	Sun, 24 Jun 2001 20:02:01 -0400
Date: Mon, 25 Jun 2001 02:05:30 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Larry McVoy <lm@bitmover.com>
Cc: "J . A . Magallon" <jamagallon@able.es>, landley@webofficenow.com,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010625020530.A10509@werewolf.able.es>
In-Reply-To: <Pine.LNX.3.96.1010622162213.32091B-100000@artax.karlin.mff.cuni.cz> <0106220929490F.00692@localhost.localdomain> <20010624234101.A1619@werewolf.able.es> <01062412555901.03436@localhost.localdomain> <20010625003002.A1767@werewolf.able.es> <20010624165024.H8832@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010624165024.H8832@work.bitmover.com>; from lm@bitmover.com on Mon, Jun 25, 2001 at 01:50:24 +0200
X-Mailer: Balsa 1.1.6-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010625 Larry McVoy wrote:
>
>One for the quotes page, eh?  We're terribly sorry, we'll get busy on adding
>some delay loops in Linux so it too can be slow.
>-- 

I was afraid someone would tell that...

I just want to say that the 'problem' is not that threads are slow in linux,
but that others ways are faster than they 'should be if done the standard
way'.

BTW, after all I have read all POSIX threads library should be no more than
a wrapper over fork(), clone and so on. Why are they so bad then ?
I am going to get glibc source to see what is inside pthread_create...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac17 #2 SMP Fri Jun 22 01:36:07 CEST 2001 i686
