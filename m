Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281105AbRKPFWv>; Fri, 16 Nov 2001 00:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRKPFWm>; Fri, 16 Nov 2001 00:22:42 -0500
Received: from card.ziele.de ([194.9.192.160]:10502 "EHLO kira.akte.de")
	by vger.kernel.org with ESMTP id <S281105AbRKPFWW>;
	Fri, 16 Nov 2001 00:22:22 -0500
KRecCount: 1
Date: Fri, 16 Nov 2001 00:18:51 -0500
From: Andy Spiegl <kernel.Andy@spiegl.de>
To: linux-kernel@vger.kernel.org
Subject: CPU crashes on Asus L8400 Laptop
Message-ID: <20011116001851.B32720@radiomaranon.org.pe>
Mail-Followup-To: Andy Spiegl <kernel.Andy@spiegl.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.23i
Organization: Radio =?iso-8859-1?B?TWFyYfHzbiw=?= Peru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Now I have search all the FAQs and the whole web, but couldn't find
anything on my problem, so I dare to ask you guys. :-)

I own an ASUS L8400 laptop with 850MHz, 256MB Ram and am running a Debian
(woody) linux with kernel 2.4.12. (after trying older ones)

My problem is that when the CPU heats up (very fast with this laptop) the
system first starts to choke (i.e. completely stops working) for between
parts of a second up to multiple seconds.  So far it's bad (e.g. makes
watching DVDs unbearable), but the worst part is that it sometimes doesn't
"wake up" anymore.  I waited 10-20 minutes, the fan keeps spinning but the
system doesn't recover anymore and I have to manually turn it off.  I think
it does have to do with the CPU temperature, because this mainly happens
when the CPU is working hard, the fan is already spinning and the
temperature is between 70 and 80°C.

First I thought this is a hardware problem, but then I booted the other
partition with Win98se.  I could start any program and it didn't even stop
for a millisecond.  I even tried the "cpuburn" that I found and the CPU
didn't crash although it heated up to almost 90°C!  It seemed to be working
slower, but it kept working.

So I think that it must have something to do with the way linux is working
with the CPU.  How else would it work fine under windows I wonder?  But I
have no idea what could be causing this really annoying behavior.  :-(

Today I tried turning CONFIG_APM_CPU_IDLE off, but that didn't help either.

Do you guys have any idea or suggestion?

Thanks a lot,
 Andy.

-- 
 Andy Spiegl, Radio Marañón, Jaén, Perú
 E-Mail: Andy@spiegl.de, Andy@radiomaranon.org.pe
 URL: http://spiegl.de, http://radiomaranon.org.pe
 PGP/GPG: see headers
                              o      _     _         _
  ------- __o       __o      /\_   _ \\o  (_)\__/o  (_)          -o)
  ----- _`\<,_    _`\<,_    _>(_) (_)/<_    \_| \   _|/' \/       /\\
  ---- (_)/ (_)  (_)/ (_)  (_)        (_)   (_)    (_)'  _\o_    _\_v
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Why do they lock gas station bathrooms?
 Are they afraid someone will clean them?
