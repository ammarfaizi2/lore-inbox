Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263071AbTCSQkl>; Wed, 19 Mar 2003 11:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263080AbTCSQkl>; Wed, 19 Mar 2003 11:40:41 -0500
Received: from zeke.inet.com ([199.171.211.198]:26025 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S263071AbTCSQkj>;
	Wed, 19 Mar 2003 11:40:39 -0500
Message-ID: <3E78A002.70004@inet.com>
Date: Wed, 19 Mar 2003 10:51:14 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: Matthias Schniedermeyer <ms@citd.de>,
       "Richard B. Johnson" <johnson@quark.analogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Everything gone!
References: <Pine.LNX.4.53.0303191041370.27397@quark.analogic.com>	 <20030319160437.GA22939@citd.de> <1048091858.989.10.camel@bip.localdomain.fake>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
> Le mer 19/03/2003 à 17:04, Matthias Schniedermeyer a écrit :
> 
> 
>>rm -rf *
>>Should do the same(*) but with much better speed.
>>
>>Normaly the system should lockup at sometime while doing it.
>>
>>
>>
>>
>>*: OK. The version above will "break" in the middle after "/bin/rm" (or
>>"/lib/libc.so.6") got deleted.
> 
> 
> That would be surprising. Did you actually try it ? :)

The complex version that you snipped would break because it invokes rm 
for each file.  The simpler version he gave would not break at that 
point because it is already running.  Hence the footnote ton the word 
'same'.

HTH,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

