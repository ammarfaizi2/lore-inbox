Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVALMEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVALMEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 07:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVALMEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 07:04:25 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:51630 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261163AbVALMEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 07:04:22 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Mariusz Mazur <mmazur@kernel.pl>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
Date: Wed, 12 Jan 2005 12:04:15 +0000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200501081613.27460.mmazur@kernel.pl> <200501121049.10219.andrew@walrond.org> <200501121211.23475.mmazur@kernel.pl>
In-Reply-To: <200501121211.23475.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121204.15255.andrew@walrond.org>
X-Spam-Score: 4.3 (++++)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 January 2005 11:11, Mariusz Mazur wrote:
>
> Looks like you've linked your kernel's config.h to llh and that causes the
> problem. You shouldn't do that unless you have a specific reason to,
> otherwise you might end up with problems I'm unable to test for (I can't
> check every possible combination of kernel CONFIG_'s).
>

It seems that mysql looks for the existence of a compilable linux/config.h and 
uses it if available. This has just happened to work until latest release of 
llh. I had read your faq, but too long ago ;)

Thanks!

Andrew
