Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVAKClA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVAKClA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVAKCk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:40:56 -0500
Received: from gw.goop.org ([64.81.55.164]:18821 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262533AbVAKCiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:38:08 -0500
Subject: Re: 2.6.10-mm2: panic when munmap()ping the stack
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1105401719.4153.2.camel@localhost>
References: <1105401719.4153.2.camel@localhost>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 18:34:53 -0800
Message-Id: <1105410893.4153.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-0.mozer.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 16:01 -0800, Jeremy Fitzhardinge wrote:
> I'm not sure if setting the signal handler is necessary or not.

The first version of this code set a SIGSEGV handler, but the panic
happens without it.

	J

