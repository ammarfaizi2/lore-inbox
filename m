Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267917AbTAHUHS>; Wed, 8 Jan 2003 15:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267916AbTAHUHS>; Wed, 8 Jan 2003 15:07:18 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:43499 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267869AbTAHUHQ>;
	Wed, 8 Jan 2003 15:07:16 -0500
Subject: Re: Getting interface IP addresses with proc filesystem
To: Burton Samograd <kruhft@kruhft.dyndns.org>
Cc: linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF6BBE4A7C.C4B419C9-ON87256CA8.006F1B9C@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Wed, 8 Jan 2003 12:16:04 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 01/08/2003 13:15:50
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                               
                                                                                                               
                                                                                                               


I proposed something along this lines but got lot of opposing remarks as I
wanted to identify a given interface as *primary*.
I think this feature is needed and we should add it to the kernel, I need
it, you need it, for sure someone else will need it.


Juan





|---------+---------------------------------->
|         |           Burton Samograd        |
|         |           <kruhft@kruhft.dyndns.o|
|         |           rg>                    |
|         |           Sent by:               |
|         |           linux-kernel-owner@vger|
|         |           .kernel.org            |
|         |                                  |
|         |                                  |
|         |           01/07/03 06:06 PM      |
|         |                                  |
|---------+---------------------------------->
  >-------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                         |
  |       To:       linux-kernel@vger.kernel.org                                                                            |
  |       cc:                                                                                                               |
  |       Subject:  Getting interface IP addresses with proc filesystem                                                     |
  |                                                                                                                         |
  >-------------------------------------------------------------------------------------------------------------------------|




Hi all,

I'm curious how one goes about getting the current IP addresses held by a
machine.  I saw some rather convoluted code in qmail that shows how to do
it but
it seems like a rather difficult (and future bug ridden if the interface
changes) piece of code and was thinking that a /proc/net interface would be
the
easiest solution, at least on the end user side.

My thinking goes along the lines of adding a file in /proc/net called
interfaces
(or something more appropriate) which gives the following type of listing:

eth0 12.35.23.58
eth0:0 192.168.0.1
lo 127.0.0.1
ppp0 45.3.3.89

etc

for each of the registered interfaces on the machine.  Nice, simple and
shouldn't be too hard to implement, correct? Is this type of information
already present through some other mechanism that I haven't found yet?

Thanks in advance.

--
burton samograd
kruhft@kruhft.dyndns.org
http://kruhftwerk.dyndns.org


#### C.DTF has been removed from this note on January 08, 2003 by Juan
Gomez


