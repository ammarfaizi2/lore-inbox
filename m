Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312331AbSC3BM1>; Fri, 29 Mar 2002 20:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312332AbSC3BMR>; Fri, 29 Mar 2002 20:12:17 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:12933 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S312331AbSC3BMJ>; Fri, 29 Mar 2002 20:12:09 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: David <david@2gen.com>
Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load togeter
Date: Sat, 30 Mar 2002 02:12:01 +0100
X-Mailer: KMail [version 1.4]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200203300212.02322.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 24. March 2002 22:18:21 David wrote:
> Hi,
>
> First off, I'd like to thank Andre Hedrick for the link to:
> http://www.tecchannel.de/hardware/817/index.html
>
> It was very helpful in making me understand why the performance of my 
> newly bought Adaptec 2400A IDE-Raid card sucked so badly in combination 
> with my VIA KT133 based board.
>
> I have done some testing (on the Win platform since that's where the 
> patches to remedy this situation are available) that shows quite nicely 
> how the PCI bus gets totally overrun by transfer rates in excess of 
> approximately 74MB/s and instead slows down.
>
> Short summary
> =============
> Expected rate           Experienced rate
> 84MB/s 
>                 50MB/s
> 80MB/s 
>                 64MB/s
> 74MB/s 
>                 74MB/s
> (If someone is very interested, mail me and I can publish some transfer 
> rate graphs online)

Can you please redo with latest VIA fix applied?

PrePatch:   http://www.tecchannel.de/hardware/817/5.html
Via Patch:  http://www.viaarena.com/?PageID=66#raid
Post Patch: http://www.tecchannel.de/hardware/817/11.html

rpp1.02.zip

Thanks,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

