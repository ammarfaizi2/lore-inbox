Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbWADCvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWADCvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 21:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWADCvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 21:51:19 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:46956 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S965173AbWADCvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 21:51:18 -0500
Date: Wed, 4 Jan 2006 03:51:09 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Adrian Bunk <bunk@stusta.de>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Takashi Iwai <tiwai@suse.de>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <20060104010123.GK3831@stusta.de>
Message-ID: <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
References: <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl>
 <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
 <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl>
 <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
 <20060104000344.GJ3831@stusta.de> <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
 <20060104010123.GK3831@stusta.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-826484282-1136340077=:29027"
Content-ID: <Pine.BSO.4.63.0601040304110.29027@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-826484282-1136340077=:29027
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.63.0601040304111.29027@rudy.mif.pg.gda.pl>

On Wed, 4 Jan 2006, Adrian Bunk wrote:

> On Wed, Jan 04, 2006 at 01:46:08AM +0100, Tomasz K?oczko wrote:
>> On Wed, 4 Jan 2006, Adrian Bunk wrote:
>> [..]
>>>> Solaris, AIX ..
>>>> Full list is avalaible in "Operating System" listbox on
>>>> http://www.4front-tech.com/download.cgi
>>>
>>> As I said in footnote 1 of my email, this has little value for
>>> application developers since only few users on these systems use this
>>> commercial sound system.
>>
>> You are wrong using pejorative labeling "commercial sound system" for
>> this. Comercial is implementation. OSS is defined by user space API.
>> This is all what was neccessary on implemting this in for Linux.
>
> The question is simple:
>
> How many percent of the Solaris or AIX users are actually using any
> sound system implementing the OSS API?

First try answer on: if OSS specyfications is complet, easy to use in 
applications and generaly compact why reinventing all from this level to 
above on Linux ? why ?
If you answer first on this question you will see: answer 
on your questions do not have sense.

Be compliant with OSS specyfication allow save many time on applications 
development level by consume (in good sense) time spend on this 
applications by *BSD, Solaris and other systems developers (even on not 
open source applications).
After four years ALSA development quality of sound support in Linux is IMO 
on the ~same (still bad) level as four years ago. Still to complicated 
but now more bloated and additionaly not ready for handle fancy gadgets 
like BT headsets.
On other systems (MOX, Win*, Solaris ..) on handle sound situations is now 
better than four years ago. IMO this allow form conclution: generaly 
current ALSA is step back compare to other systems and probaly Linux need 
some deeper work then simple polishing sound device drivers.

More than year Linux in many publications is described as "excelent 
system for mobile gadgets". All waits for this ..
Most of this gadgets want uses sound. Force using ALSA in this are makes 
nightmares not only for drivers developers but also for user space 
applications developers.

(IMO in comming year or two if nothing will change Linux can be visable 
marginalized/can loose current possition .. not because in this period 
Linux will be worse compare to now but because other systems like Solaris, 
MOX and also Win* can pass in this period better progress on bringing some 
valuable functionalities in usable/simpler form for joe-like users .. 
remember: sound support in Linux isn't for data centers/big-ass-machines :)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-826484282-1136340077=:29027--
