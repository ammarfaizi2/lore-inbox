Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUFEXhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUFEXhT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 19:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUFEXhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 19:37:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22996 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262425AbUFEXhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 19:37:17 -0400
Date: Sat, 5 Jun 2004 19:37:15 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVuIC8gVHJvbmlj?= <tronic2@sci.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: Some thoughts about cache and swap
In-Reply-To: <40C1DB59.7090507@sci.fi>
Message-ID: <Pine.LNX.4.44.0406051935380.29273-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2004, [UTF-8] Lasse Kärkkäinen / Tronic wrote:

> In order to make better use of the limited cache space, the following
> methods could be used:

	[snip magic piled on more magic]

I wonder if we should just bite the bullet and implement
LIRS, ARC or CART for Linux.  These replacement algorithms
should pretty much detect by themselves which pages are
being used again (within a reasonable time) and which pages
aren't.

Especially CART looks interesting.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

