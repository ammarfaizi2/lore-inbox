Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVLTCfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVLTCfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 21:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVLTCfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 21:35:55 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46508 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750754AbVLTCfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 21:35:54 -0500
Date: Mon, 19 Dec 2005 20:35:37 -0600
From: Robin Holt <holt@sgi.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Robin Holt <holt@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, rth@redhat.com, bj0rn@blox.se
Subject: Re: Can somebody with flex/bison experience help with genksyms?
Message-ID: <20051220023537.GA27004@lnx-holt.americas.sgi.com>
References: <20051219214019.GA25888@lnx-holt.americas.sgi.com> <jelkygljkg.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jelkygljkg.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 01:05:03AM +0100, Andreas Schwab wrote:
> -	| TYPEOF_KEYW '(' decl_specifier_seq ')'
> +	| TYPEOF_KEYW '(' decl_specifier_seq m_abstract_declarator ')'

Thank you.  It was on the STRUCT_KEYW a few lines down and now it
works.  I will post shortly.

Thanks,
Robin
