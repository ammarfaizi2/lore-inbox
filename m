Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272583AbTHKNo1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272589AbTHKNoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:44:06 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:33241
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S272583AbTHKNjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:39:23 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Timothy Miller <miller@techsource.com>,
       Charlie Baylis <cb-lkml@fish.zetnet.co.uk>
Subject: Re: [PATCH] O12.2int for interactivity
Date: Mon, 11 Aug 2003 04:14:28 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F303494.3030406@techsource.com>
In-Reply-To: <3F303494.3030406@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308110414.28569.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 18:49, Timothy Miller wrote:

> Or closer to the point:
>
> "For each record player, there is a record which it cannot play."
> For more detail, please read this dialog:
> http://www.geocities.com/g0del_escher_bach/dialogue4.html
...
> The interactivity detection algorithm will always be inherently
> imperfect.  Given that it is not psychic, it cannot tell in advance
> whether or not a given process is supposed to be interactive, so it must
> GUESS based on its behavior.

Another way of looking at it is that every time you remove a bottleneck, the 
next most serious problem becomes the new bottleneck.

Does this mean it's a bad idea to stop trying to identify the next bottleneck?  
(Whether or not you then choose to deal with it is another question...)

Rob

