Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWEPXA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWEPXA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 19:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWEPXA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 19:00:27 -0400
Received: from ozlabs.org ([203.10.76.45]:14218 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932223AbWEPXA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 19:00:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17514.22914.122341.182962@cargo.ozlabs.ibm.com>
Date: Wed, 17 May 2006 09:00:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: Fix broken PIO with libata
In-Reply-To: <4469F43C.3080406@pobox.com>
References: <1147790393.2151.62.camel@localhost.localdomain>
	<4469F169.2050708@gmail.com>
	<4469F43C.3080406@pobox.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:

> More parens == easier to review.  So

Well... mostly, but not always.  I agree about a && (b & c), but I
find the parens in ((a == b) && (c != d)) distracting.  And once we
get to three or more parens in a row, I have to start counting
carefully to see where they match up.

Paul.
