Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbTLFK6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 05:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTLFK6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 05:58:13 -0500
Received: from holomorphy.com ([199.26.172.102]:19926 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265060AbTLFK6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 05:58:12 -0500
Date: Sat, 6 Dec 2003 02:58:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Colin Coe <colin@coesta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Message-ID: <20031206105806.GO8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Colin Coe <colin@coesta.com>, linux-kernel@vger.kernel.org
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com> <20031206024251.GG8039@holomorphy.com> <3FD14396.5070205@cyberone.com.au> <20031206030755.GI8039@holomorphy.com> <3704.192.168.1.3.1070694142.squirrel@www.coesta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3704.192.168.1.3.1070694142.squirrel@www.coesta.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 03:02:22PM +0800, Colin Coe wrote:
> Sorry about the delay.
> Booted with noirqbalance.

This leads to a similar conclusion to Stian Jordet's case. It's not
mistaking you for HT, it's the lack of an internal distinction between
the cases that need and don't need irq balancing.


-- wli
