Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWILH4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWILH4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWILH4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:56:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35809 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964972AbWILH4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:56:52 -0400
Subject: Re: i386 PDA patches use of %gs
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: akpm@osdl.org, ak@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <4506665D.2090001@goop.org>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org>
	 <4506665D.2090001@goop.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 12 Sep 2006 09:56:46 +0200
Message-Id: <1158047806.2992.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 00:48 -0700, Jeremy Fitzhardinge wrote:
> Arjan van de Ven wrote:
> > Jeremy, is there a reason you're specifically using %gs and not %fs? If
> > not, would you mind a switch to using %fs instead?
> >   
> 
> The main reason for using %gs was to take advantage of gcc's TLS 
> support.  I intend to measure the cost of gs vs fs, and if there's a 
> significant difference I'll switch.

gcc can be fixed if needed. I don't see the kernel switching to use that
any time soon though...


