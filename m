Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTKYAcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTKYAcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:32:42 -0500
Received: from zero.aec.at ([193.170.194.10]:47368 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261820AbTKYAcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:32:41 -0500
Date: Tue, 25 Nov 2003 01:32:33 +0100
From: Andi Kleen <ak@muc.de>
To: John Blackwood <john.blackwood@ccur.com>
Cc: linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: [PATCH] arch/x86_64/kernel/signal.c linux-2.6.0-test10
Message-ID: <20031125003232.GA19764@averell>
References: <3FC26F78.10303@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC26F78.10303@ccur.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 03:52:08PM -0500, John Blackwood wrote:
> Hi Andi,
> 
> In linux-2.6.0-test10, I believe that there are several lines of code
> in the x86_64 version of handle_signal() that will not ever be executed
> and can most likely be removed.
> 
> I also believe that there are several lines that should be added to the
> end of the do_signal() routine for handling the -ERESTART_RESTARTBLOCK
> case.

Thanks, John. Was a mismerge. I added the change to my tree.

-Andi
