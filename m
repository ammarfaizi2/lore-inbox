Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbUKPPTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbUKPPTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 10:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUKPPTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 10:19:10 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:37898 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S262011AbUKPPTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 10:19:04 -0500
Message-Id: <200411161518.iAGFIL604810@blake.inputplus.co.uk>
To: Pekka Enberg <penberg@gmail.com>
cc: Simon Braunschmidt <braunschmidt@corscience.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace 
In-Reply-To: Message from Pekka Enberg <penberg@gmail.com> 
   of "Tue, 16 Nov 2004 13:20:38 +0200." <84144f0204111603202f79f249@mail.gmail.com> 
Date: Tue, 16 Nov 2004 15:18:20 +0000
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Pekka Enberg wrote:
> No, that is obfuscation and has nothing to do with this. The cast I
> mentioned is _redudant_ because the common case is:
> 
>     struct foo * f = (struct foo *) priv; /* priv is void pointer */

These casts are also a problem when priv changes type;  the compiler is
being told to not complain.

Cheers,


Ralph.

