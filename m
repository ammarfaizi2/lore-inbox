Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbTLMWdy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 17:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265304AbTLMWdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 17:33:54 -0500
Received: from holomorphy.com ([199.26.172.102]:56706 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265303AbTLMWdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 17:33:52 -0500
Date: Sat, 13 Dec 2003 14:33:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use-after-free in pte_chain in 2.6.0-test11
Message-ID: <20031213223349.GU8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
References: <20031213220459.GA22152@vana.vc.cvut.cz> <20031213221320.GT8039@holomorphy.com> <20031213223208.GB25959@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213223208.GB25959@vana.vc.cvut.cz>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 02:13:20PM -0800, William Lee Irwin III wrote:
>> CONFIG_DEBUG_PAGEALLOC should have oopsed this...

On Sat, Dec 13, 2003 at 11:32:08PM +0100, Petr Vandrovec wrote:
> Maybe pte_chain is too small to get unmapped (it is 128 bytes here)? Or it is 
> really hardware bug :-(

The alignment flags prevent it.

Anyhow, 6a vs. 5a/5b looks like a bitflip...


-- wli
