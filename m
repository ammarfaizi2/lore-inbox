Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbTFRIkx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 04:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbTFRIkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 04:40:52 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:21134 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265110AbTFRIkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 04:40:51 -0400
Message-ID: <3EF02B37.4050806@free.fr>
Date: Wed, 18 Jun 2003 11:04:55 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
References: <3EE66C86.8090708@free.fr> <Pine.LNX.4.55L.0306172019550.31986@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0306172019550.31986@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> My plan for 2.4.22 is:
> 
>  - Include the new aic7xxx driver.
>  - Include ACPI. (I now realized its importance). Already discussing with
>    Andrew the best way to do it.
>  - Fix the latency/interactivity problems (Chris, Nick and Andrea working
> on that)
>  - Merge obviously correct -aa VM patches.
> 
> Those are the most important things that are needed now, I think.

I think many people on this list will be delighted to read this. I'm 
looking for the 22-pre to help testing them (UP)... As alan said, 
increasing the user test base may cause to find some remaining bugs but 
as many people are already forced to patch their 2.4 kernel with aic7xxx 
and ACPI just to make it useable most severe/obvious bugs have probably 
already been found...

I think SMP server users will also be happy with the rest of proposed fixes.

Side comments just to try to make 2.4 even better : I think polling the 
list to see the most annoying problems or most requested feature people 
have/want is sometime a good idea. Of course you will always get mail 
from people that what a patch to have support for their baroque hardware 
but I think you may reach a consensus rapidly as in the previous (rude) 
mail exchanges.

Hope you will manage to spend the needed time to make this in a timely 
fashion.

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

