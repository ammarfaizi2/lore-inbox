Return-Path: <linux-kernel-owner+w=401wt.eu-S1161056AbWLUNA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWLUNA5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 08:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWLUNA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 08:00:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56169 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161056AbWLUNA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 08:00:56 -0500
Subject: Re: [patch] change WARN_ON back to "BUG: at ..."
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <20061221124327.GA17190@elte.hu>
References: <20061221124327.GA17190@elte.hu>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 21 Dec 2006 14:00:47 +0100
Message-Id: <1166706047.3365.1501.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +		printk("BUG: at %s:%d %s()\n", __FILE__,		\

how about

BUG: Warning at .... 



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

