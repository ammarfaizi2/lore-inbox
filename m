Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSGNHYN>; Sun, 14 Jul 2002 03:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSGNHYM>; Sun, 14 Jul 2002 03:24:12 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.43]:34474 "EHLO
	phoebe.oisec.net") by vger.kernel.org with ESMTP id <S315629AbSGNHYL>;
	Sun, 14 Jul 2002 03:24:11 -0400
Date: Sun, 14 Jul 2002 09:27:06 +0200
From: Cliff Albert <cliff@oisec.net>
To: Arjan Opmeer <a.d.opmeer@student.utwente.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with kernel BUG at dcache.c:345
Message-ID: <20020714072706.GA27582@oisec.net>
Mail-Followup-To: Arjan Opmeer <a.d.opmeer@student.utwente.nl>,
	linux-kernel@vger.kernel.org
References: <20020710054916.GA1800@Ado.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020710054916.GA1800@Ado.student.utwente.nl>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using M$ Outlook ? You should try mutt!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 07:49:16AM +0200, Arjan Opmeer wrote:

> My Linux machine just crashed during the morning cronjob with an Oops. Yes,
> I know my kernel is tainted because I have the NVidia driver loaded, but
> consider that maybe this driver is not the direct cause of the Oops but only
> exposing an obscure bug in the kernel?
> 
> It also seems that enabling AGP using the kernel agpgart module makes this
> Oops more likely to happen. Also forcing the AGP rate to 1x instead of 2x
> does not seem to make any difference. With AGP disabled this machine reaches
> quite respectable uptimes despite using the NVidia driver...
> 
> Because the machine was hung with the screen blanked I could not use
> ksymoops, but this is the output of my syslog:
> 

<SNIP>

I had almost the same problem on a 2.4.19-rc1 kernel WITHOUT nvidia crap.
However after replacing my CPU (Celeron 600A) with a Pentium III 733
problems disappeared (at least until now)

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | http://oisec.net/
cliff@oisec.net		| 6BONE:     CA2-6BONE	 |
