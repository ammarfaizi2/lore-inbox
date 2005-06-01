Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVFAHzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVFAHzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 03:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVFAHzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 03:55:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:490 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261323AbVFAHy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 03:54:59 -0400
Date: Wed, 1 Jun 2005 09:54:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
Message-ID: <20050601075414.GA25081@elte.hu>
References: <1117594659.3798.18.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117594659.3798.18.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> I've abstracted priority inheritance from the RT patch. I created pi.h 
> and pi.c that can be used by other structures that need priority 
> inheritance. I also added a config option CONFIG_PRIORITY_INHERITANCE 
> so that PI can be turned off . This could also be made completely 
> separate from the RT patch.

i'd rather not slow things down by callbacks and other abstraction 
before seeing how things want to integrate in fact. Do we really need 
the callbacks?

	Ingo
