Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVDRMYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVDRMYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVDRMYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:24:55 -0400
Received: from Smtp2.univ-nantes.fr ([193.52.82.19]:19120 "EHLO
	smtp2.univ-nantes.fr") by vger.kernel.org with ESMTP
	id S262053AbVDRMYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:24:48 -0400
Message-ID: <4263A70F.5060409@univ-nantes.fr>
Date: Mon, 18 Apr 2005 14:24:47 +0200
From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Organization: CRIUN
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :(
References: <20050414214828.GB9591@mail.muni.cz> <4263A3B7.6010702@univ-nantes.fr> <20050418122202.GE26030@mail.muni.cz>
In-Reply-To: <20050418122202.GE26030@mail.muni.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek a écrit :

>On Mon, Apr 18, 2005 at 02:10:31PM +0200, Yann Dupont wrote:
>  
>
>>I have those problems too. The (temporary ?) fix is to raise the
>>min_free_kb to an higher value.
>>echo 65535 > /proc/sys/vm/min_free_kbytes
>>
>>Maybe such an high value is totally silly, but at least I don't have
>>those messages.
>>    
>>
>
>I know that kernel 2.6.6-bk4 works. So were there some memory manager changes
>since 2.6.6? If so it looks like there are some bugs. 
>On the other hand, ethernet driver should not allocate much memory but rather
>drop packets.
>
>Btw, are you using some TCP tweaks? E.g. I have default TCP window size 1MB.
>
>  
>
No tweaking at all. No jumbo frames.


-- 
Yann Dupont, Cri de l'université de Nantes
Tel: 02.51.12.53.91 - Fax: 02.51.12.58.60 - Yann.Dupont@univ-nantes.fr

