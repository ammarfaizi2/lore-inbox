Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWFTP7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWFTP7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWFTP7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:59:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33248 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751353AbWFTP7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:59:03 -0400
Subject: Re: [PATCH] Unify CONFIG_LBD and CONFIG_LSF handling
From: Arjan van de Ven <arjan@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, webmaster@cyberdogtech.com
In-Reply-To: <Pine.LNX.4.64.0606201742280.12900@scrub.home>
References: <20060619221618.GJ1630@parisc-linux.org>
	 <Pine.LNX.4.64.0606201616430.17704@scrub.home>
	 <20060620145234.GK1630@parisc-linux.org>
	 <Pine.LNX.4.64.0606201742280.12900@scrub.home>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 17:59:00 +0200
Message-Id: <1150819141.2891.214.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Or is that too verbose?
> 
> How likely is it that someone who doesn't understand the question needs 
> this option? I think N is a safe answer here.

N is not the safe answer; Y is. If you set it to N you can't read all
your files (if there is a big one) etc etc.
The safe-but-a-bit-slower answer really is Y.


