Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTK1VRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 16:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTK1VRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 16:17:30 -0500
Received: from holomorphy.com ([199.26.172.102]:64707 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263486AbTK1VR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 16:17:29 -0500
Date: Fri, 28 Nov 2003 13:16:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Breno <brenosp@brasilsec.com.br>
Cc: linux-kernel@vger.kernel.org, M?ns Rullg?rd <mru@kth.se>
Subject: Re: Question - non-exec stack
Message-ID: <20031128211655.GA8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Breno <brenosp@brasilsec.com.br>, linux-kernel@vger.kernel.org,
	M?ns Rullg?rd <mru@kth.se>
References: <000701c3b5b3$addfbac0$34dfa7c8@bsb.virtua.com.br> <yw1xu14o1ub0.fsf@kth.se> <001501c3b5b7$84c5bd20$34dfa7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001501c3b5b7$84c5bd20$34dfa7c8@bsb.virtua.com.br>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 11:57:09AM -0200, Breno wrote:
> Yes , 32 bit Intel processors

Due to the really hard drugs the processor designers must have been
on, the only way to implement this is via the particularly nasty flavor
of segmentation on Intel processors (sane forms just use bits in pointers).

c.f. pax and exec-shield for examples of how to do it in Linux (please
do not start that debate; the only relevant point here is they use the
segmentation stuff). I suspect OpenBSD might also implement it.


-- wli
