Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264462AbTEJR6U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 13:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTEJR6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 13:58:20 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:57728 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264462AbTEJR6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 13:58:20 -0400
Date: Sat, 10 May 2003 19:10:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jos Hulzink <josh@stack.nl>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use correct x86 reboot vector
Message-ID: <20030510181056.GB29682@mail.jlokier.co.uk>
References: <20030510025634.GA31713@averell> <20030510161529.GB29271@mail.jlokier.co.uk> <200305102141.57860.josh@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305102141.57860.josh@stack.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink wrote:
> For the sake of bad behaving BIOSes however, I'd vote for the f000:fff0 
> vector, unless someone can hand me a paper that says it is wrong.

I agree, for the simple reason that it is what the chip does on a
hardware reset signal.

-- Jamie
