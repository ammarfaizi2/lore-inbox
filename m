Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265253AbUGGRqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUGGRqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUGGRqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:46:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41950 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265253AbUGGRqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:46:45 -0400
Date: Wed, 7 Jul 2004 13:46:41 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: linux-kernel@vger.kernel.org, <justin.piszcz@mitretek.org>
Subject: Re: Does Optimization Effect BogoMips Value?
In-Reply-To: <Pine.LNX.4.60.0407071113400.24640@p500>
Message-ID: <Pine.LNX.4.44.0407071345420.20572-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, Justin Piszcz wrote:

> Three identical Virtual Machines with three different compiler flags to
> compile the entire distribution, in this case, Gentoo 2004.1.
> 
> However, why are the Bogomips values different (up to +82 points
> different)?

It really doesn't matter for performance. A higher
bogomips value just means the system will spin more
delay loops to wait the same amount of time...

For more details, see http://funroll-loops.org/

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

