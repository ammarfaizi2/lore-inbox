Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbUCJJbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 04:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbUCJJbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 04:31:22 -0500
Received: from ns.suse.de ([195.135.220.2]:60848 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261456AbUCJJbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 04:31:21 -0500
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Redirection of STDERR
References: <20040308111349.030feea6.Christoph.Pleger@uni-dortmund.de>
	<404DEAFD.8090802@bcgreen.com> <jehdwylz0x.fsf@sykes.suse.de>
	<20040310085039.6c234fbc.Christoph.Pleger@uni-dortmund.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: ..  Now KEN and BARBIE are PERMANENTLY ADDICTED to MIND-ALTERING
 DRUGS..
Date: Wed, 10 Mar 2004 10:31:19 +0100
In-Reply-To: <20040310085039.6c234fbc.Christoph.Pleger@uni-dortmund.de> (Christoph
 Pleger's message of "Wed, 10 Mar 2004 08:50:39 +0100")
Message-ID: <jek71tkpzs.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Pleger <Christoph.Pleger@uni-dortmund.de> writes:

> I found out that the problem exists with bash 2.05b, but not with 2.05a.
> The reason is that with 2.05a the command uses the file descriptors
> under /dev/fd0 for the pipe, but with 2.05b the command creates a pipe
> under /tmp. Obviously, the 2.05b mechanism worked with Kernel 2.4, but
> not with 2.6.

Works fine here, please make sure that your bash isn't misconfigured.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
