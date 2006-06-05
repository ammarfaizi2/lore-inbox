Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751018AbWFEQzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWFEQzS (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWFEQzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:55:18 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:21204 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751018AbWFEQzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:55:16 -0400
Date: Mon, 5 Jun 2006 09:55:03 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Florin Malita <fmalita@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, kurt.hackel@oracle.com,
        linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] ocfs2: dereference before NULL check in ocfs2_direct_IO_get_blocks()
Message-ID: <20060605165503.GJ3082@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <4481AC0F.6040805@gmail.com> <20060603191558.GA7268@martell.zuzino.mipt.ru> <44821B82.1040406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44821B82.1040406@gmail.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2006 at 07:30:10PM -0400, Florin Malita wrote:
> Great, then the NULL branch is dead code and we can fix consistency
> differently:
Ok, this one seems much more reasonable. Thanks for the patch Florin.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
