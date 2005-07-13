Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVGML1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVGML1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVGML1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 07:27:15 -0400
Received: from web52902.mail.yahoo.com ([206.190.49.12]:16988 "HELO
	web52902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262616AbVGML1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 07:27:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=r/q9zrj97YWOS2v8hRTxi9J0/XPsI56w93ZP+0+uIH+mU9UBdEzuaJdqVaCRTlUPEvCdyFWoDeTXcXrdkfD2+oTwaApE1wUz1EvfiMH7zawCFOCb3mZHIzxDsxfJ0V9THL8Y/leYRVBjt+v69BnRahLD+gVocQnod+q9reVSJso=  ;
Message-ID: <20050713112710.60204.qmail@web52902.mail.yahoo.com>
Date: Wed, 13 Jul 2005 13:27:09 +0200 (CEST)
From: szonyi calin <caszonyi@yahoo.com>
Subject: RE: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ck list <ck@vds.kolivas.org>, caszonyi@rdslink.ro
In-Reply-To: <200507122110.43967.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Con Kolivas <kernel@kolivas.org> a écrit :

> 	Interbench - The Linux Interactivity Benchmark v0.20
> 
> http://interbench.kolivas.org
> 
> direct download link:
> http://ck.kolivas.org/apps/interbench/interbench-0.20.tar.bz2
> 
>
[snip]
 
> Audio:
> Audio is simulated as a thread that tries to run at 50ms
> intervals that then
> requires 5% cpu. This behaviour ignores any caching that would
> normally be 
> done by well designed audio applications, but has been seen as
> the interval 
> used to write to audio cards by a popular linux audio player.
> It also ignores 
> any of the effects of different audio drivers and audio cards.
> Audio can also 
> be run as a real time SCHED_FIFO task.
> 

I have the following problem with audio:
Xmms is running with threads for audio and spectrum
analyzer(OpenGL).
The audio eats 5% cpu, the spectrum analyzer about 80 %. The
problem is that sometimes the spectrum analyzer is eating all of
the cpu while the audio is skipping. Xmms is version 1.2.10
kernel is vanilla, latest "stable" version 2.6.12, suid root.

Does your benchmark simultes this kind of behaviour ? 
 

> 
> Cheers,
> Con Kolivas
> 

I'll give it a try
Thanks
Calin


--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
