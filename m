Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWGCKkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWGCKkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWGCKkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:40:07 -0400
Received: from colin.muc.de ([193.149.48.1]:51462 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751096AbWGCKkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:40:07 -0400
Date: 3 Jul 2006 12:40:05 +0200
Date: Mon, 3 Jul 2006 12:40:05 +0200
From: Andi Kleen <ak@muc.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: drepper@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pselect/ppoll support on x86_64
Message-ID: <20060703104005.GB5415@muc.de>
References: <1151919711.3000.82.camel@pmac.infradead.org> <1151920035.3000.88.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151920035.3000.88.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 10:47:15AM +0100, David Woodhouse wrote:
> This adds support for the pselect and ppoll system calls on x86_64. 
> 
> Andi suggests that it might be too late for the 2.6.18 merge window -- I
> disagree. I consider it a bug fix, since I don't think we intend x86_64
> to be a secondary architecture and lag behind i386 and PowerPC in its
> system call support. Andi's TIF_RESTORE_SIGMASK implementation is
> heavily based on the i386 version, where it's had lots of testing
> already.

I've got burned badly by these patches last time and the 2.6.18 merge
window is closed.

I'll add them for testing, but it's 2.6.19 material.

-Andi
