Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUBYXtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbUBYXq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:46:26 -0500
Received: from imladris.surriel.com ([66.92.77.98]:26605 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261621AbUBYXns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:43:48 -0500
Date: Wed, 25 Feb 2004 18:45:02 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
To: John Lee <johnl@aurema.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
In-Reply-To: <Pine.GSO.4.03.10402260130140.2680-100000@swag.sw.oz.au>
Message-ID: <Pine.LNX.4.55L.0402251842460.1835@imladris.surriel.com>
References: <Pine.GSO.4.03.10402260130140.2680-100000@swag.sw.oz.au>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, John Lee wrote:

> Only one heuristic

I really like the fact that this patch gets rid of most
of the "magic tricks" that the current O(1) scheduler
needs in order to work well for most interactive users.

> O(1) task promotion

... while still being O(1)

The share based stuff should also tie in nicely with
the various resource management projects out there.

cheers,

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
