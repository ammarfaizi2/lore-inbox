Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWG3Rds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWG3Rds (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWG3Rds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:33:48 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10967 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932380AbWG3Rdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:33:47 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
References: <44CC97A4.8050207@gmail.com> <44CCC4CA.6000208@argo.co.il>
	<1154271283.2941.27.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@suse.de>
Date: 30 Jul 2006 19:33:41 +0200
In-Reply-To: <1154271283.2941.27.camel@laptopd505.fenrus.org>
Message-ID: <p73y7ub2e16.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:
> 
> unfortunately this only works for MMX not for real fpu (due to exception
> handling uglies)

He can always disable all FPU exceptions in his code or make sure
there aren't any.

-Andi
