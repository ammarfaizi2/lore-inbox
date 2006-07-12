Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWGLU1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWGLU1N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWGLU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:27:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46767 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751056AbWGLU1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:27:13 -0400
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality
	permits it
From: Arjan van de Ven <arjan@infradead.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200607122312.19909.a1426z@gawab.com>
References: <200607112257.22069.a1426z@gawab.com>
	 <p73sll6n73t.fsf@verdi.suse.de>  <200607122312.19909.a1426z@gawab.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 22:27:08 +0200
Message-Id: <1152736028.3217.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 23:12 +0300, Al Boldi wrote:

> It already checks for it, but makes no difference.
> 
> Thanks for looking into this!
> 

well glibc also randomizes things a bit (for better cache coloring) ...


