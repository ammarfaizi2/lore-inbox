Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933883AbWKWT5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933883AbWKWT5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933888AbWKWT5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:57:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34772 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933885AbWKWT5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:57:48 -0500
Subject: Re: [PATCH] PCI MMConfig: Detect and support the E7520 and the
	945G/GZ/P/PL
From: Arjan van de Ven <arjan@infradead.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20061123195137.GA35120@dspnet.fr.eu.org>
References: <20061123195137.GA35120@dspnet.fr.eu.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 23 Nov 2006 20:57:41 +0100
Message-Id: <1164311861.3147.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 20:51 +0100, Olivier Galibert wrote:
> It seems that the only way to reliably support mmconfig in the
> presence of funky biosen is to detect the hostbridge and read where
> the window is mapped from its registers.  Do that for the E7520 and
> the 945G/GZ/P/PL on x86-64 for a start.


hi,

while I like this approach a lot, I am wondering if this shouldn't be
done as a PCI quirk instead.... it would make a lot of sense to use that
shared infrastructure for this...


