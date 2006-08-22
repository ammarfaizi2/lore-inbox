Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWHVNSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWHVNSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWHVNSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:18:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54953 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932220AbWHVNSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:18:31 -0400
Subject: Re: [RFC] kallsyms_lookup always requires buffers
From: Arjan van de Ven <arjan@infradead.org>
To: Franck <vagabon.xyz@gmail.com>
Cc: rusty@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44EAFDCA.1080002@innova-card.com>
References: <44EAFDCA.1080002@innova-card.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 22 Aug 2006 15:18:26 +0200
Message-Id: <1156252706.2976.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +}
> +EXPORT_SYMBOL_GPL(kallsyms_lookup_gently);


Hi,

there don't seem to be modular users so please don't export it since
that export just eats up useless space. (we have way too many of those
already)

(Also I suggest you submit at least one user with your patch but that's
another matter)

Greetings,
   Arjan van de Ven

