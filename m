Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTDUXYC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTDUXYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:24:02 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:9092 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S262675AbTDUXYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:24:02 -0400
Date: Tue, 22 Apr 2003 00:35:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@muc.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching
Message-ID: <20030421233557.GB17595@mail.jlokier.co.uk>
References: <20030421192734.GA1542@averell> <Pine.LNX.4.44.0304211254190.17221-100000@home.transmeta.com> <20030421205333.GA13883@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421205333.GA13883@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> The patching code is quite generic and could be used to patch other
> instructions

Such as removing the lock prefix when running non-SMP?

-- Jamie
