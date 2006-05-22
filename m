Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWEVOIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWEVOIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWEVOIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:08:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:61092 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750839AbWEVOIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:08:24 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH 2/6, 2nd try] reliable stack trace support (x86-64)
Date: Mon, 22 May 2006 16:08:18 +0200
User-Agent: KMail/1.9.1
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
References: <4471D5CC.76E4.0078.0@novell.com>
In-Reply-To: <4471D5CC.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605221608.18434.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 15:16, Jan Beulich wrote:
> These are the x86_64-specific pieces to enable reliable stack traces. The
> only restriction with this is that it currently cannot unwind across the
> interrupt->normal stack boundary, as that transition is lacking proper
> annotation.

that comment should be outdated now? 

-Andi
