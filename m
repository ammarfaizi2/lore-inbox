Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbTGBJgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTGBJgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:36:05 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:44689 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264889AbTGBJft
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:35:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Luis Miguel Garcia <ktech@wanadoo.es>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O1int 0307021808 for interactivity
Date: Wed, 2 Jul 2003 19:53:59 +1000
User-Agent: KMail/1.5.2
References: <20030702111720.084843e9.ktech@wanadoo.es>
In-Reply-To: <20030702111720.084843e9.ktech@wanadoo.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307021953.59294.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003 19:17, Luis Miguel Garcia wrote:
> Con,
>
> I have not tested the latest patch from you, but I'm actually running with
> the one you made public yesterday and it behaves VERY strangely. Sometime,
> with only XMMS and aMSN (an Instant Messaging app), if I pick an xterm and
> move it around the screen very fast, xmms stops clearly until I stop doing
> bad things with the window.

Yes indeed the old one would do that. The time constant was 10 seconds so an 
app would have to be running for up to 50 seconds before it was balanced. 
This new one fixes that by applying a non linear boost with time.

> Other times, even when I'm compiling something, I can do that with the
> windows and XMMS doesn't stop at all.

After a minute of running xmms I'd say.

> Very strange, not to?

Not at all :)

> When I have time, I'll test you patch from today.

Great.

Con

