Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVE3QkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVE3QkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 12:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVE3QkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 12:40:10 -0400
Received: from colin.muc.de ([193.149.48.1]:7440 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261646AbVE3QkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 12:40:05 -0400
Date: 30 May 2005 18:40:03 +0200
Date: Mon, 30 May 2005 18:40:03 +0200
From: Andi Kleen <ak@muc.de>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, john cooper <john.cooper@timesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: spinaphore conceptual draft
Message-ID: <20050530164003.GB8141@muc.de>
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <m1r7fpvupa.fsf@muc.de> <429B289D.7070308@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429B289D.7070308@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 08:52:13AM -0600, Chris Friesen wrote:
> Andi Kleen wrote:
> 
> >On many architectures (including popular ones like AMD x86-64) 
> >there is no reliable fast monotonic (1) count unfortunately 
> 
> What about rdtsc?

It fails the reliable and monotonic test on AMD; on Intel EM64T machines
it fails the fast test (although the alternatives are even slower) and
also the first ones one a few bigger ones.

-Andi
