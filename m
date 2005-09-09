Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVIIInH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVIIInH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVIIInG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:43:06 -0400
Received: from ns2.suse.de ([195.135.220.15]:52661 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932542AbVIIInF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:43:05 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH] fix x86-64 condition to call nmi_watchdog_tick
Date: Fri, 9 Sep 2005 10:43:01 +0200
User-Agent: KMail/1.8
Cc: "Jan Beulich" <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <43207ED00200007800024566@emea1-mh.id2.novell.com>
In-Reply-To: <43207ED00200007800024566@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091043.01659.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 18:11, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
>
> Don't call nmi_watchdog_tick() when this isn't enabled.

Hmm, I think i will concur with Zwane's objection to this for now.

-Andi
