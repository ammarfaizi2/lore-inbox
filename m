Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUHBXRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUHBXRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUHBXRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:17:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22681 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263865AbUHBXQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:16:59 -0400
Date: Mon, 2 Aug 2004 19:16:56 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
In-Reply-To: <cemgno$hun$2@abraham.cs.berkeley.edu>
Message-ID: <Xine.LNX.4.44.0408021905320.2260-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004, David Wagner wrote:

> The point I was making is that there are other scenarios where Cryptoloop
> falls apart in much more devastating ways.  For instance, if the attacker
> can modify the ciphertexts stored on your hard disk and you continue
> using the hard disk afterwards, then really nasty attacks become possible.
> Other attacks become possible if the attacker can observe the ciphertexts
> stored on your hard disk at multiple points in time.  The question I was
> asking is this: Does anyone care about these latter types of scenarios?

I think the common threat scenarios out of the above are:

1) Attacker can observe ciphertexts at multiple points in time.
2) Attacker steals disk/computer and disappears with it.


- James
-- 
James Morris
<jmorris@redhat.com>


