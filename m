Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbULYNzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbULYNzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbULYNzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:55:16 -0500
Received: from holomorphy.com ([207.189.100.168]:46019 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261506AbULYNzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:55:08 -0500
Date: Sat, 25 Dec 2004 05:55:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: domen@coderock.org
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/4] delete unused file
Message-ID: <20041225135502.GY771@holomorphy.com>
References: <20041225134127.EE9D64DC08C@golobica.uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225134127.EE9D64DC08C@golobica.uni-mb.si>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 02:41:37PM +0100, domen@coderock.org wrote:
> Remove nowhere referenced file. (egrep "filename\." didn't find anything)
> Signed-off-by: Domen Puncer <domen@coderock.org>

include/asm-alpha/numnodes.h is included by include/linux/numa.h when
CONFIG_NUMA is set. grepping for the filename can be fooled.


-- wli
