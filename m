Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318775AbSIFP6p>; Fri, 6 Sep 2002 11:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318772AbSIFP6p>; Fri, 6 Sep 2002 11:58:45 -0400
Received: from mail1.cirrus.com ([141.131.3.20]:46731 "EHLO mail1.cirrus.com")
	by vger.kernel.org with ESMTP id <S318767AbSIFP6o>;
	Fri, 6 Sep 2002 11:58:44 -0400
Message-ID: <973C11FE0E3ED41183B200508BC7774C05233F87@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <tom.woller@cirrus.com>
To: "'Rik van Riel'" <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, "Woller, Thomas" <tom.woller@cirrus.com>
Subject: RE: cs4281 & select in 2.4
Date: Fri, 6 Sep 2002 11:01:31 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

which 2.4 version are you using? 2.4.19?  There was a ham-radio
select(2) fix in the cs4281 driver back in 2.4.17 era, think that
it got into the 2.4.18 kernel tree.  I just checked the 2.4.19
kernel and the fix does seem to be included.  i'll place a tarbz2
file out on an FTP server, and if you can try this driver, that
would help me out.  if the driver does not build under your tree,
let me know, it's circa 2.4.17 and i don't know the 2.4.19 mods
concerning drivers. 
server: ftp1.cirrus.com
Username:     ftppclink
Password:     cSPxQMd

i'll put cs4281-src-20011214-01n-tar.bz2 into \cs4281 directory.
thanks
Tom

-----Original Message-----
From: Rik van Riel [mailto:riel@conectiva.com.br]
Sent: Thursday, September 05, 2002 7:20 PM
To: twoller@crystal.cirrus.com
Cc: pcaudio@crystal.cirrus.com; linux-kernel@vger.kernel.org
Subject: cs4281 & select in 2.4


Hi,

it looks like select() is broken for the cs4281 sound driver
in the 2.4 kernel. This breaks pretty much all GUI ham radio
applications that use the sound card ;(

I've done some tracing on various ham radio applications, but
none of the ones that use select() get any data from the cs4281
driver.

The applications tried include glfer and hamfax.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org
