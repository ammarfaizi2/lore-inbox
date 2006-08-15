Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965315AbWHOJm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965315AbWHOJm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965340AbWHOJm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:42:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57033 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965315AbWHOJm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:42:56 -0400
Subject: Re: [PATCH] Change pci_module_init from macro to inline function
	marked as deprecated
From: Arjan van de Ven <arjan@infradead.org>
To: Henne <henne@nachtwindheim.de>
Cc: gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
In-Reply-To: <44E18DE2.8020700@nachtwindheim.de>
References: <44E18DE2.8020700@nachtwindheim.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 15 Aug 2006 11:42:47 +0200
Message-Id: <1155634967.3011.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 11:03 +0200, Henne wrote:
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Replaces the pci_module_init()-macro with a inline function,
> which is marked as deprecated.
> This gives a warning at compile time, which may be useful for driver developers who still use
> pci_module_init() on 2.6 drivers.

Hi,

good work, but  please stick this also in feature-removal.txt with a
hard date on it, otherwise we can never get rid of it.....

Greetings,
   Arjan van de Ven

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

