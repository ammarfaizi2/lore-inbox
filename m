Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVFVPlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVFVPlj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVFVPg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:36:29 -0400
Received: from opersys.com ([64.40.108.71]:60172 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261458AbVFVPcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:32:47 -0400
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
From: Kristian Benoit <kbenoit@opersys.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <42B9845B.8030404@opersys.com>
References: <1119287612.6863.1.camel@localhost>
	 <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com>
	 <20050622011931.GF1324@us.ibm.com>  <42B9845B.8030404@opersys.com>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 11:27:58 -0400
Message-Id: <1119454078.5825.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-22 at 11:31 -0400, Karim Yaghmour wrote:
>                      +----------+
>                      |   HOST   |
>                      +----------+
>                           |
>                           |
>                           | Ethernet LAN
>                           |
>                          / \
>                         /   \
>                        /     \
>                       /       \
>                      /         \
>                     /           \
>                    /             \
>             +--------+  SERIAL  +--------+
>             | LOGGER |----------| TARGET |
>             +--------+          +--------+

Karim mean:
                     +----------+
                     |   HOST   |
                     +----------+
                          |
                          |
                          | Ethernet LAN
                          |
                         / \
                        /   \
                       /     \
                      /       \
                     /         \
                    /           \
                   /             \
            +--------+ PARALLEL +--------+
            | LOGGER |----------| TARGET |
            +--------+          +--------+

Kristian

