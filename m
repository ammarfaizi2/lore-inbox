Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWITJ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWITJ4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 05:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWITJ4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 05:56:06 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50593 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750891AbWITJ4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 05:56:03 -0400
From: Andi Kleen <ak@suse.de>
To: "Michael Kerrisk" <mtk-manpages@gmx.net>
Subject: Re: TCP stack behaviour question
Date: Wed, 20 Sep 2006 11:55:58 +0200
User-Agent: KMail/1.9.3
Cc: "Stuart MacDonald" <stuartm@connecttech.com>, linux-kernel@vger.kernel.org
References: <005501c6db44$102b73a0$294b82ce@stuartm> <20060919145024.46580@gmx.net>
In-Reply-To: <20060919145024.46580@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609201155.58197.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Interestingly, at this point in the man pages source there
> is the following commented out text:

Yes that was me. On second thought I suppose I was right back then that this 
feature is too dubious to be documented. So better keep it
undocumented and drop the change.

-Andi

> 
> .\" FIXME . Is it a good idea to document that? It is a dubious feature.
> .\" On
> .\" .B SOCK_STREAM
> .\" sockets,
> .\" .I IP_RECVERR
> .\" has slightly different semantics. Instead of
> .\" saving the errors for the next timeout, it passes all incoming
> .\" errors immediately to the user.
> .\" This might be useful for very short-lived TCP connections which
> .\" need fast error handling. Use this option with care:
> .\" it makes TCP unreliable
> .\" by not allowing it to recover properly from routing
> .\" shifts and other normal
> .\" conditions and breaks the protocol specification.
> 
> Cheers,
> 
> Michael
