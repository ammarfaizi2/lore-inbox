Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUFXM6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUFXM6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 08:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUFXM61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 08:58:27 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:29193 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264515AbUFXM5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 08:57:45 -0400
Date: Thu, 24 Jun 2004 14:57:42 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: FabF <fabian.frederick@skynet.be>
Cc: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.7-mm1] MBR centralization
Message-ID: <20040624125742.GF3072@pclin040.win.tue.nl>
References: <1088025348.2213.32.camel@localhost.localdomain> <20040623213629.GC3072@pclin040.win.tue.nl> <1088057276.1901.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088057276.1901.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : mailhost.tue.nl 1182; Body=1 Fuz1=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 08:07:57AM +0200, FabF wrote:

> Here's a new version:

> -               if (!msdos_magic_present(data + 510))
> +               if (!MSDOS_MBR (data+510))

Not an improvement.
