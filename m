Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTK1VP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 16:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTK1VP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 16:15:27 -0500
Received: from ivoti.terra.com.br ([200.176.3.20]:62644 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S263467AbTK1VPX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 16:15:23 -0500
Date: Fri, 28 Nov 2003 19:15:20 -0200
From: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: sisopiii-l@cscience.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [SisopIII-l] Re: [PATCH] fix #endif misplacement
Message-Id: <20031128191521.01fbe86c.rnsanchez@terra.com.br>
In-Reply-To: <3FC781F4.7070201@terra.com.br>
References: <20031128141927.5ff1f35a.rnsanchez@terra.com.br>
	<Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de>
	<3FC77A59.2090705@elipse.com.br>
	<3FC7803D.2050203@cyberone.com.au>
	<3FC781F4.7070201@terra.com.br>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting  Felipe W Damasio <felipewd@terra.com.br>
Sent on  Fri, 28 Nov 2003 15:12:20 -0200

> 	Hi Nick,
> 
> Nick Piggin wrote:
> > The ifdef isn't pretty, but its performance critical code, its easy to
> > understand, and there is a big comment above it. I think its OK the
> > way it is. Not that you would ever notice any difference probably.
> 
> 	You're right. As Lucas already pointed out, the ifdef CONFIG_NUMA is
> actually an ifndef...
> 	Like myself, I think Ricardo overlooked this :)

Oops!  Completely overlooked this.  Thanks for correcting me :)


-- 
Ricardo Nabinger Sanchez
GNU/Linux #140696 [http://counter.li.org]
Slackware Linux

  Warning: 
    Trespassers will be shot.
    Survivors will be shot again.
