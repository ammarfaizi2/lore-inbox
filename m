Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTK1RMg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 12:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbTK1RMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 12:12:36 -0500
Received: from ivoti.terra.com.br ([200.176.3.20]:21387 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262746AbTK1RMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 12:12:34 -0500
Message-ID: <3FC781F4.7070201@terra.com.br>
Date: Fri, 28 Nov 2003 15:12:20 -0200
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Lista da disciplina de Sistemas Operacionais III 
	<sisopiii-l@cscience.org>,
       Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [SisopIII-l] Re: [PATCH] fix #endif misplacement
References: <20031128141927.5ff1f35a.rnsanchez@terra.com.br> <Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de> <3FC77A59.2090705@elipse.com.br> <3FC7803D.2050203@cyberone.com.au>
In-Reply-To: <3FC7803D.2050203@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Nick,

Nick Piggin wrote:
> The ifdef isn't pretty, but its performance critical code, its easy to
> understand, and there is a big comment above it. I think its OK the
> way it is. Not that you would ever notice any difference probably.

	You're right. As Lucas already pointed out, the ifdef CONFIG_NUMA is 
actually an ifndef...

	Like myself, I think Ricardo overlooked this :)

	Cheers,

Felipe

