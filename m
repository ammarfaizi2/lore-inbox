Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVAQO7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVAQO7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 09:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVAQO7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 09:59:14 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:46790 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262816AbVAQO7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 09:59:12 -0500
In-Reply-To: <1105956993.26551.327.camel@hades.cambridge.redhat.com>
References: <1105956993.26551.327.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <38A2A735-6898-11D9-AF22-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: <hpa@zytor.com>, "Olaf Hering" <olh@suse.de>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>,
       <linuxppc-dev@ozlabs.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] raid6: altivec support
Date: Mon, 17 Jan 2005 08:58:17 -0600
To: "David Woodhouse" <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

> This makes it compile on PPC, but highlights the difference between
>  'cur_cpu_spec' on ppc32 and ppc64. Why is 'cur_cpu_spec' an array on
>  ppc32? Isn't 'cur' supposed to imply 'current'?

I can only guess to handle an SMP case with two different revs of the 
same processor that might have slightly different errata.

- kumar

