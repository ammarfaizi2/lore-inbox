Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSKTWOH>; Wed, 20 Nov 2002 17:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbSKTWOH>; Wed, 20 Nov 2002 17:14:07 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:61059 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S262871AbSKTWOE>; Wed, 20 Nov 2002 17:14:04 -0500
Message-ID: <3DDC0AC8.9070308@nortelnetworks.com>
Date: Wed, 20 Nov 2002 17:20:56 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nero <neroz@iinet.net.au>
Cc: Felix Seeger <felix.seeger@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.48 QM_MODULES: Function not implemented
References: <200211202004.20261.felix.seeger@gmx.de> <3DDBF02D.4060005@iinet.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nero wrote:
> Felix Seeger wrote:
>  > I can't load a module, I get this: modprobe: Can't open dependencies
>  > file /lib/modules/2.5.48/modules.dep ...
>  >
>  > depmod: QM_MODULES: Function not implemented
>  >
>  > I enabled all option in the module config.
> 
> You need Rusty's modutils from here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/module-init-tools-0.7.tar.bz2 


Rusty's stuff will let you load, but you'll still get the depmod error. 
  It would have been nice to have a version of depmod that does nothing 
normally but calls the old version on an older kernel.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

