Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTJIWnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTJIWnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:43:50 -0400
Received: from fep04-svc.mail.telepac.pt ([194.65.5.203]:36509 "EHLO
	fep04-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S262081AbTJIWnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:43:49 -0400
Message-ID: <3F85E43A.2050605@vgertech.com>
Date: Thu, 09 Oct 2003 23:42:02 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Maciej Zenczykowski <maze@cela.pl>
CC: herft <herft@sedal.usyd.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: CPU Usage for particular User Login
References: <Pine.LNX.4.44.0310092157290.30889-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0310092157290.30889-100000@gaia.cela.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Maciej Zenczykowski wrote:
>>You can also run a lot of top programs, each for one user (type 'u' 
>>while in top).
>>
>>Regards,
>>Nuno Silva
> 
> 
> nb. is their a way to get fair 'equal time / proc percentage per user' 
> queueing of the CPU(s).

Yes. Rik, IIRC, has a "fair cpu scheduler". I've seen several version of 
this patch to 2.4. Not sure about 2.6, thou...

You may also want to inspect CKRM (Class-based Kernel Resource 
Management) in http://ckrm.sourceforge.net/

Regards,
Nuno Silva


> 
> i.e. not limiting the number of processes/user but limiting the total CPU 
> 'power' in use by a given user, something like the CBQ network 
> schedulers... perhaps with some classes (like root) more priveledged 
> etc... or is this something for 2.7?
> 
> Cheers,
> MaZe.
> 
> 

