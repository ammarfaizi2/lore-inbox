Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265302AbTLMWN1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 17:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbTLMWN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 17:13:27 -0500
Received: from holomorphy.com ([199.26.172.102]:52354 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265302AbTLMWN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 17:13:26 -0500
Date: Sat, 13 Dec 2003 14:13:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use-after-free in pte_chain in 2.6.0-test11
Message-ID: <20031213221320.GT8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
References: <20031213220459.GA22152@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213220459.GA22152@vana.vc.cvut.cz>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 11:04:59PM +0100, Petr Vandrovec wrote:
>   today I get this one while attempting to build new kernel. Running kernel is
> 2.6.0-test11-c1511 (bk as of 2003-12-05 23:35:35-08:00). Does anybody
> have any clue what could happen, or should I start looking for a new
> memory modules?
>   AMD K7/1GHz box, 512MB RAM, no vmmon/vmnet loaded since reboot, gcc-3.3.2
> as of last week Debian unstable. Kernel built with all possible memory 
> debugging enabled... 
>   Unfortunately I have no idea which process did this clone() call, and
> whether it succeeded or died. 

CONFIG_DEBUG_PAGEALLOC should have oopsed this...


-- wli
