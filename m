Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRFHSnz>; Fri, 8 Jun 2001 14:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbRFHSnp>; Fri, 8 Jun 2001 14:43:45 -0400
Received: from jalon.able.es ([212.97.163.2]:49325 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262389AbRFHSnh>;
	Fri, 8 Jun 2001 14:43:37 -0400
Date: Fri, 8 Jun 2001 20:43:06 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "Michael H . Warfield" <mhw@wittsend.com>
Cc: Chris Boot <bootc@worldnet.fr>, "Michael H . Warfield" <mhw@wittsend.com>,
        mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>,
        "L . K ." <lk@aniela.eu.org>,
        "Albert D . Cahalan" <acahalan@cs.uml.edu>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
Message-ID: <20010608204306.C2768@werewolf.able.es>
In-Reply-To: <20010607212138.B29121@alcove.wittsend.com> <B746D8FA.F994%bootc@worldnet.fr> <20010608140553.C20944@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010608140553.C20944@alcove.wittsend.com>; from mhw@wittsend.com on Fri, Jun 08, 2001 at 20:05:53 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.08 Michael H. Warfield wrote:
> 
> 	Actually, the REAL point I was TRYING to make (and doing a really
> shabby job of it) is that some of this needs a little dose of reality.
> We don't have sensors that are accurate to 1/10 of a K and certainly not
> to 1/100 of a K.  Knowing the CPU temperature "precise" to .01 K when
> the accuracy of the best sensor we are likely to see is no better than
> +- 1 K is just about as relevant as negative absolute temperatures.

Lets see, somebody can develop lab equipment (dont think on PTRs or
thermistors in common world) that givee 10e-3 precission, and you are just
making linux not suitable to control that hardware. Think open.
What is the real difference between managing temperatures with a short
or a long ?. Is it really needed to fit it in a short ??!!!
I would use an unsigned long with fixed point and all done.
 
-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac9 #1 SMP Wed Jun 6 09:57:46 CEST 2001 i686
