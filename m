Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWJIG7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWJIG7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 02:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWJIG7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 02:59:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27066 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751676AbWJIG7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 02:59:35 -0400
Subject: Re: [PATCH] [kernel/ subdirectory] constifications
From: Arjan van de Ven <arjan@infradead.org>
To: Helge Deller <deller@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200610082121.49925.deller@gmx.de>
References: <200610082121.49925.deller@gmx.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 09 Oct 2006 08:59:29 +0200
Message-Id: <1160377169.3000.189.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 21:21 +0200, Helge Deller wrote:
> - completely constify string arrays,  thus move them to the rodata section

note that gcc 4.1 and later will do this automatically for static things
at least...


