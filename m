Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbWADBi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWADBi5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWADBi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:38:57 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:39822 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S964816AbWADBi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:38:56 -0500
Date: Wed, 4 Jan 2006 02:38:49 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Stefan Smietanowski <stesmi@stesmi.com>
cc: Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <43BB16C0.3080308@stesmi.com>
Message-ID: <Pine.BSO.4.63.0601040146540.29027@rudy.mif.pg.gda.pl>
References: <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl>
 <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org>
 <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl>
 <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
 <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl>
 <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
 <43BB16C0.3080308@stesmi.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1850946630-1136338729=:29027"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1850946630-1136338729=:29027
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 4 Jan 2006, Stefan Smietanowski wrote:
[..]
>> Solaris, AIX ..
>> Full list is avalaible in "Operating System" listbox on
>> http://www.4front-tech.com/download.cgi
>
> Are all those Operatings Systems that include OSS per default, no
> additional download required? Because that's what he's asking for,
> not what you can get OSS for.
>
> Since that link is a _download page_ it makes me think that it's
> an _additional download_ to get OSS support on those (or some of
> those) operating systems.

So start another "it makes me think" and imagine that in Solaris case 
using drivers not provided directly on distribution level is NORMAL habit. 
Why ? Bacause Solaris have well defined kernel API (from many years in 
some common areas it is constants which makes 
Documentation/stable_api_nonsense.txt from Linux tree piece of crap). This 
allow use device drivers prepared first for example for older kernels 
(8,9) on latest (10). I.e.: Solaris 10 inroduces stop supporting some 
older network cards (IIRC for old SMC cards). I know people which still 
uses this cards on Sol10 by using binary drivers prepared for older 
Solarises without visable problems. Also many device drivers have double 
versions (one from distribution resouurces and second provided by device 
vendor).

Summarize: stop looking on sound subsystem problems as Linux specyfic and 
assume that THE SAME problems exists on other unices in so simillar form
so is possible thinking on OSS support on kernel level details in the 
same forms as on other unices. Linux case isn't so unusual in this area .. 
it is VERY typical :>
If you will take this as true you can start looking on OSS API on Linux
from correct point of view.
And start asking ALSA people: why using OSS API in other unices 
simple works and it ins't problem and on Linux "it was so big problem 
that reinventing sound support in ALSA form was neccessary" ?

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1850946630-1136338729=:29027--
