Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUIJLGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUIJLGV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 07:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUIJLGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 07:06:21 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:15796 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S267359AbUIJLFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 07:05:54 -0400
Message-ID: <41418A90.5050303@free.fr>
Date: Fri, 10 Sep 2004 13:05:52 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Petko Manolov <petkan@nucleusys.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4 badness in rtl8150.c ethernet driver : fixed
References: <413DB68C.7030508@free.fr> <4140256C.5090803@free.fr> <20040909152454.14f7ebc9.akpm@osdl.org> <20040909223605.GA17655@kroah.com> <Pine.LNX.4.61.0409101212420.22115@bender.nucleusys.com>
In-Reply-To: <Pine.LNX.4.61.0409101212420.22115@bender.nucleusys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petko Manolov wrote:

> Steven Hein <ssh@sgi.com> sent me a patch that supposedly fix device 
> registers misinitialization when it is being frequently reseted.

I never saw traces showing the card should be resetted. It hung 
occasionnaly in the past but did not know who to really blame (USB vs 
drivers). It is now  working well for quite a long time now allthough I 
periodically transfers more than 100mb via ftp...

> I would say lets wait for some time and see if we'll break someone else's
> heart and then reverse the patch.  Another solution is to restore the 
> original value and add new module parameter, so whoever thinks
> anything != 0x10 work better for him will be free to change it.

I'm not sure 2.6.9-rcx-mmx will provide valuable data, we will probably 
have to wait until distro incoporates this code to get some reasonnable 
hints... Do you have some well known driver users you could ping to get 
feedback more quickly?


Anyway, you are aware of the problem and I know how to fix my problem so 
all is fine.

Have a nice day,

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



