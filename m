Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbUKSLfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbUKSLfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 06:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUKSLfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 06:35:33 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:47551 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261356AbUKSLf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 06:35:29 -0500
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
From: David Woodhouse <dwmw2@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041119103418.GB30441@wotan.suse.de>
References: <20041119005117.GM4943@stusta.de>
	 <20041119085132.GB26231@wotan.suse.de> <419DC922.1020809@pobox.com>
	 <20041119103418.GB30441@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1100863700.21273.374.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 19 Nov 2004 11:28:20 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 11:34 +0100, Andi Kleen wrote:
> Basically what Paul Menage said. There is a lot of common code,
> and you would end up writing X86 && X86_64 more often than
> X86 && !X86_64.

(assuming you meant the first to be X86 || X86_64)

Can you show some examples? We don't have this for any other
architecture.

-- 
dwmw2


