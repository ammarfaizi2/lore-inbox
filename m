Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266772AbUGLJXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266772AbUGLJXT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 05:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUGLJVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 05:21:32 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:46527 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266769AbUGLJVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 05:21:16 -0400
Date: Mon, 12 Jul 2004 11:21:12 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: marcelo.tosatti@cyclades.com.br, linux-kernel@vger.kernel.org
Subject: Re: BK-kernel-tools/shortlog update
Message-ID: <20040712092112.GA5979@merlin.emma.line.org>
Mail-Followup-To: marcelo.tosatti@cyclades.com.br,
	linux-kernel@vger.kernel.org
References: <20040712090607.DFCFAC3662@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712090607.DFCFAC3662@merlin.emma.line.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, Matthias Andree wrote:

> Hello Linus,
> 
> you can either use "bk receive" to patch with this mail,
> or you can
> Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
> or in cases of dire need, you can apply the patch below.
> 
> BK: Parent repository is http://bktools.bkbits.net/bktools
> 
> Patch description:
> ChangeSet@1.201, 2004-07-12 11:04:45+02:00, matthias.andree@gmx.de
>   * Implement address precedence logic

Note that this changes does:

1. if From: is present in a ChangeLog test, use that
2. if no From: is present, use the topmost Signed-off-by: header
3. If neither is present, use BK_USER@BK_HOST as per the ChangeSet@...
   line.
