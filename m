Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUFNIMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUFNIMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUFNIMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:12:31 -0400
Received: from [213.146.154.40] ([213.146.154.40]:17873 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262045AbUFNILY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:11:24 -0400
Date: Mon, 14 Jun 2004 09:11:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [2/12] lower priority of "too many keys" msg in atkbd.c
Message-ID: <20040614081123.GB7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614003459.GQ1444@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 05:34:59PM -0700, William Lee Irwin III wrote:
>  * Lowered priority of "too many keys" message in drivers/input/keyboard/atkbd.c
> This fixes Debian BTS #239036.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=239036
> 
> 	From: "Jon Thackray" <jgt@pobox.com>
> 	Message-ID: <16476.11084.179640.444619@localhost.localdomain>
> 	To: submit@bugs.debian.org
> 	Subject: Keyboard misbehaving
> 
> The keyboard under 2.6.4 seems to be behaving strangely, reporting
> unknown key codes and too many keys pressed, even when no keys have
> been pressed. The keyboard is connected via an 8 way KVM switch, but
> was working quite acceptably under 2.4.25 with no such messages.
> Trying 2.6.3 is not an option as it doesn't support the hardware
> properly, as previously reported.

I already sent this patch to lkml, please read up the discussion that
happened on it here.

