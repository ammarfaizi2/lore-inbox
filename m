Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275278AbTHSBLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275279AbTHSBLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:11:49 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:24449 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275278AbTHSBLr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:11:47 -0400
Date: Tue, 19 Aug 2003 02:11:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Narayan Desai <desai@mcs.anl.gov>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: weird pcmcia problem
Message-ID: <20030819011131.GG11081@mail.jlokier.co.uk>
References: <87u18efpsc.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u18efpsc.fsf@mcs.anl.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Narayan Desai wrote:
> Running 2.6.0-test3 (both with and without your recent yenta socket
> patches) pcmcia cards present during boot don't show up until they are
> removed and reinserted. Once reinserted, they work fine. This only
> seems to occur if yenta_socket is build into the kernel; if support is
> modular, cards appear to be recognized properly at boot time. I am
> running on a thinkpad t21.  Let me know if I can help with this
> problem in any way...  thanks

I see the same problem.  "cardctl eject; cardctl insert" is enough to
get the card recognised for me.

-- Jamie
