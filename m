Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUIMH6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUIMH6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 03:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIMH5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 03:57:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62858 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266351AbUIMH5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 03:57:20 -0400
Date: Mon, 13 Sep 2004 09:57:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com, cw@f00f.org, anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040913075743.GA15722@elte.hu>
References: <1095045628.1173.637.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095045628.1173.637.camel@cube>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Albert Cahalan <albert@users.sf.net> wrote:

> I'd much prefer LRU allocation. There are
> lots of system calls that take PID values.
> All such calls are hazardous. They're pretty
> much broken by design.

this is a pretty sweeping assertion. Would you
care to mention a few examples of such hazards?

> BTW, since pid_max is now adjustable, reducing
> the default to 4 digits would make sense. [...]

i'm not sure what you mean by 'now', pid_max has
been adjustable for quite some time.

	Ingo
