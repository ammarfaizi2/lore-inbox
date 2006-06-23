Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWFWCmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWFWCmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 22:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWFWCmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 22:42:43 -0400
Received: from [198.99.130.12] ([198.99.130.12]:25226 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750906AbWFWCmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 22:42:43 -0400
Date: Thu, 22 Jun 2006 22:42:22 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060623024222.GA8316@ccure.user-mode-linux.org>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622213443.GA22303@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 05:34:43PM -0400, Theodore Tso wrote:
> When I tried compiling 2.6.17-mm1 without SKAS support, it failed to
> link:

Why are you trying to do that?  tt mode is bitrotting - the only
reason it is still there is that skas mode doesn't fully support SMP
yet.  If SMP is the reason, then I'll add the necessary support and
send in the patch.

				Jeff
