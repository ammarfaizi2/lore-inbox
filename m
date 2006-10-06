Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWJFEbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWJFEbS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 00:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWJFEbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 00:31:17 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:49164 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1750742AbWJFEbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 00:31:17 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: linux-kernel@vger.kernel.org
Subject: Re: Merge window closed: v2.6.19-rc1
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
Date: Thu, 05 Oct 2006 21:31:16 -0700
In-Reply-To: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> (message from
	Linus Torvalds on Wed, 4 Oct 2006 20:29:16 -0700 (PDT))
Message-ID: <871wpmoyjv.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> so please give it a good testing, and let's see if there are any 
> regressions.

it breaks suspend when the airo module is loaded:

kernel: Stopping tasks: =================================================================================
kernel:  stopping tasks timed out after 20 seconds (1 tasks remaining):
kernel:   eth1
kernel: Restarting tasks...<6> Strange, eth1 not stopped

if i remove the airo module suspend works normally (this is on a
thinkpad t40).

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
