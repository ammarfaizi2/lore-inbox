Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTDQB5D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 21:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbTDQB5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 21:57:03 -0400
Received: from imladris.surriel.com ([66.92.77.98]:53703 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S262513AbTDQB5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 21:57:02 -0400
Date: Wed, 16 Apr 2003 22:08:53 -0400 (EDT)
From: Rik van Riel <riel@imladris.surriel.com>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
cc: "David S. Miller" <davem@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compile fix for br2684 
In-Reply-To: <200304170153.h3H1rOGi007109@locutus.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.50L.0304162207380.18306-100000@imladris.surriel.com>
References: <200304170153.h3H1rOGi007109@locutus.cmf.nrl.navy.mil>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003, chas williams wrote:
> In message <Pine.LNX.4.44.0304162107370.12494-100000@chimarrao.boston.redhat.com>,Rik van Riel writes:
> >It looks like the recent ATM updates forgot br2684.c, here is
> >the patch needed to make that driver compile.
>
> forgive me, but i didnt think the recvq to sk->receive_queue changes were
> in the 2.4 kernel series yet?

Marcelo pulled them in recently:

$ bk changes | head -20
...
ChangeSet@1.1006.2.33, 2003-04-03 04:39:49-08:00, chas@locutus.cmf.nrl.navy.mil
  [ATM]: Fix IPHASE build with debugging enabled.

cheers,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
