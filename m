Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTIRUm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 16:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTIRUm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 16:42:29 -0400
Received: from holomorphy.com ([66.224.33.161]:26329 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262128AbTIRUm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 16:42:28 -0400
Date: Thu, 18 Sep 2003 13:43:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG at mm/memory.c:1501 in 2.6.0-test5
Message-ID: <20030918204335.GB4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
References: <20030918202758.GA26435@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918202758.GA26435@vana.vc.cvut.cz>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 10:27:58PM +0200, Petr Vandrovec wrote:
> EIP:    0060:[<c015be10>]    Tainted: PF 

                snprintf(buf, sizeof(buf), "Tainted: %c%c%c",
                        tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
                        tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
                        tainted & TAINT_UNSAFE_SMP ? 'S' : ' ');

This is probably the reason you're not getting much in the way of a
response.


-- wli
