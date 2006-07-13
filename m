Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWGMOKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWGMOKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWGMOKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:10:38 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:8832 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751502AbWGMOKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:10:38 -0400
Date: Thu, 13 Jul 2006 15:10:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] correct oldconfig for unset choice options
Message-ID: <20060713141036.GA24611@linux-mips.org>
References: <Pine.LNX.4.64.0607131315230.12900@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607131315230.12900@scrub.home>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 01:22:38PM +0200, Roman Zippel wrote:

> oldconfig currently ignores unset choice options and doesn't ask for them.
> Correct the SYMBOL_DEF_USER flag of the choice symbol to be only set if 
> it's set for all values.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

Thanks, this patch solves my problem.

   Ralf
