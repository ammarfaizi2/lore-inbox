Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287040AbSABWcP>; Wed, 2 Jan 2002 17:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287069AbSABWb7>; Wed, 2 Jan 2002 17:31:59 -0500
Received: from tourian.nerim.net ([62.4.16.79]:7690 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S287040AbSABW33>;
	Wed, 2 Jan 2002 17:29:29 -0500
Message-ID: <3C3389C7.405@free.fr>
Date: Wed, 02 Jan 2002 23:29:27 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Golden <david.golden@oceanfree.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system.map
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201022028.04945@xsebbi.de> <3C337AC8.2020900@free.fr> <02010222155300.11915@golden1.goldens.ie>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Golden wrote:

> On Wednesday 02 January 2002 21:25, Lionel Bouton wrote:
> it and
> 
>>search it in numerous places : with or without `-uname -r` appended (at
>>least in / /boot /usr/src/linux).
>>
>>
> 
> :-( Pity it apparently doesn't search
> 
> /boot/`uname -r`/System.map
> 
> That way the /boot/kernelver/* scheme (see previous post) would work...
> 
> 


As these utilities already look in several locations (most `uname -r` 
dependent), a patch to make them look in /boot/`uname -r` too would 
probably be trivial.

rgrep -r "/usr/src/linux" utility-src
vi files_found
diff -r -u old-src new-src \
	| mail -s "Small cool patch" utility-maintainer

LB.

