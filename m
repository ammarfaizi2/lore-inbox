Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWFLILb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWFLILb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWFLILb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:11:31 -0400
Received: from mx1.suse.de ([195.135.220.2]:63642 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750848AbWFLILa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:11:30 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 built-in command line
References: <20060611215530.GH24227@waste.org>
From: Andi Kleen <ak@suse.de>
Date: 12 Jun 2006 10:11:24 +0200
In-Reply-To: <20060611215530.GH24227@waste.org>
Message-ID: <p73odwyssib.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> This patch allows building in a kernel command line on x86 as is
> possible on several other arches.

I'm surprised you didn't do the obvious "tiny" changes associated with
that. Look at the static array sizes of the command line buffers.

-Andi
