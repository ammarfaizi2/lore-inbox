Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUD2Br1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUD2Br1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUD2Br0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:47:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33155 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262547AbUD2BrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:47:25 -0400
Date: Wed, 28 Apr 2004 21:46:35 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: brettspamacct@fastclick.com, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <20040428180038.73a38683.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Andrew Morton wrote:

> You really don't want hundreds of megabytes of BloatyApp's untouched
> memory floating about in the machine.

But people do.  The point here is LATENCY, when a user comes
back from lunch and continues typing in OpenOffice, his system
should behave just like he left it.

Making the user have very bad interactivity for the first
minute or so is a Bad Thing, even if the computer did run
more efficiently while the user wasn't around to notice...

IMHO, the VM on a desktop system really should be optimised to
have the best interactive behaviour, meaning decent latency
when switching applications.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

