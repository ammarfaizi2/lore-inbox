Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVDTHMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVDTHMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 03:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVDTHMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 03:12:38 -0400
Received: from Smtp1.univ-nantes.fr ([193.52.82.18]:29159 "EHLO
	smtp1.univ-nantes.fr") by vger.kernel.org with ESMTP
	id S261357AbVDTHM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 03:12:26 -0400
Message-ID: <426600D8.5060900@univ-nantes.fr>
Date: Wed, 20 Apr 2005 09:12:24 +0200
From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Organization: CRIUN
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: E1000 - page allocation failure - saga continues :(
References: <20050414214828.GB9591@mail.muni.cz> <4263A3B7.6010702@univ-nantes.fr> <20050418122202.GE26030@mail.muni.cz> <4264B202.9080304@univ-nantes.fr> <20050419080424.GA28153@mail.muni.cz>
In-Reply-To: <20050419080424.GA28153@mail.muni.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek a écrit :

>On Tue, Apr 19, 2005 at 09:23:46AM +0200, Yann Dupont wrote:
>  
>
>>Do you have turned NAPI on ??? I tried without it off on e1000 and ...
>>surprise !
>>Don't have any messages since 12H now (usually I got those in less than 1H)
>>    
>>
>
>I have NAPI on. I tried to turn it off but my test failed, I can see allocation
>failure again.
>
>  
>
Well. forgives me :)
I have re turned NAPI On and my box is still happy 19H later...

So it's obviously not napi.

The problem is beetween the 2 incarnations of kernel (2.6.11.7 with
kswapd meesages on thoses who works well), I've changed some more options
Not exactly the best way to track bugs :(

Anyway i'll try to catch THE option that make the kernel not so happy
under heavy stress. Stay tuned,

-- 
Yann Dupont, Cri de l'université de Nantes
Tel: 02.51.12.53.91 - Fax: 02.51.12.58.60 - Yann.Dupont@univ-nantes.fr

