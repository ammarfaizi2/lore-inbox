Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVDSIPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVDSIPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 04:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVDSIPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 04:15:36 -0400
Received: from Smtp2.univ-nantes.fr ([193.52.82.19]:61353 "EHLO
	smtp2.univ-nantes.fr") by vger.kernel.org with ESMTP
	id S261394AbVDSIP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 04:15:28 -0400
Message-ID: <4264BE1F.50508@univ-nantes.fr>
Date: Tue, 19 Apr 2005 10:15:27 +0200
From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Organization: CRIUN
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: E1000 - page allocation failure - saga continues :(
References: <20050414214828.GB9591@mail.muni.cz>	 <4263A3B7.6010702@univ-nantes.fr> <20050418122202.GE26030@mail.muni.cz>	 <4264B202.9080304@univ-nantes.fr> <1113897810.5074.66.camel@npiggin-nld.site>
In-Reply-To: <1113897810.5074.66.camel@npiggin-nld.site>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin a écrit :

>
>>Do you have turned NAPI on ??? I tried without it off on e1000 and ...
>>surprise !
>>Don't have any messages since 12H now (usually I got those in less than 1H)
>>
>>    
>>
>
>Possibly kswapd might be unable to get enough CPU to free memory.
>
>  
>
Ok, so what you're saying is that turning NAPI off is just slowing down
things enough to not be hit by
this problem , right ?


-- 
Yann Dupont, Cri de l'université de Nantes
Tel: 02.51.12.53.91 - Fax: 02.51.12.58.60 - Yann.Dupont@univ-nantes.fr

