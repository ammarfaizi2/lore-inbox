Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161194AbWALTSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWALTSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWALTSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:18:04 -0500
Received: from bno-84-242-95-19.nat.karneval.cz ([84.242.95.19]:10662 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1161194AbWALTSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:18:03 -0500
Message-ID: <43C6AB66.2040509@liberouter.org>
Date: Thu, 12 Jan 2006 20:17:58 +0100
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Alexander Wagner <a.wagner@physik.uni-wuerzburg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1[4,5]: battery info lost
References: <20060112173752.GN16769@wptx44.physik.uni-wuerzburg.de>
In-Reply-To: <20060112173752.GN16769@wptx44.physik.uni-wuerzburg.de>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Wagner napsal(a):
> Problem: Linux seems to loose the battery information in recent kernels.
> 
> Keywords: Battery, ACPI, 2.6.14.x, 2.6.15
> 
> Description:
> 
> Since 2.6.14 I notice that after some time the Kernel seems
> to loose the battery information via ACPI. This behaviour
> is reproducable though I do not know how to provoke it (it
> just happens). Occurs as well on the R52 from which are the
> logs below as on my T41p. On LKML this problem seems also
> to be mentioned by Narayan Desai and the same issues seems
> to be reported by Alejandro Bonilla Beeche and Geoff Mishkin
> mentioning this problem on other IBMs. As the latter uesed
Me too with 2.6.15 on asus m6r. In 2.6.14 helped ec_burst=1 kernel parameter. I
will try few things with that and let you know (tomorrow or the day after).
It is broken since 2.6.14 times, IIRC 2.6.13 was OK.
I have also problems with irqs I found out yesterday. Don't know if it does have
sth. to do with this [acpi] problem (I mean LOC: 4394987, ERR: 891474, timer is
4394964).

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
