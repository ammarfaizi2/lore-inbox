Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbTHYGJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 02:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTHYGJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 02:09:10 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:51076 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261474AbTHYGJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 02:09:08 -0400
Date: Mon, 25 Aug 2003 07:09:00 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: jim.houston@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030825060900.GA21213@mail.jlokier.co.uk>
References: <1061498486.3072.308.camel@new.localdomain> <16197.14968.235907.128727@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16197.14968.235907.128727@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> I double-checked AP-485 (24161823.pdf, the "real" reference to CPUID),
> and it says (section 3.4) that SEP is unsupported when the signature
> as a whole is less that 0x633. This means all PPros, and PII Model 3s
> with steppings less than 3.

"SEP is unsupported".  It's interesting that Pentium Pro erratum #82
is "SYSENTER/SYSEXIT instructions can implicitly load 'null segment
selector' to SS and CS registers", implying that SYSENTER does
_something_ useful on PPros.

-- Jamie
