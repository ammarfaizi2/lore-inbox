Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266010AbUGOD7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266010AbUGOD7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 23:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUGOD7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 23:59:44 -0400
Received: from holomorphy.com ([207.189.100.168]:64417 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266010AbUGOD7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 23:59:37 -0400
Date: Wed, 14 Jul 2004 20:59:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Naveed Latif <naveedlatif786@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 7 GB RAM Drive
Message-ID: <20040715035929.GM3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Naveed Latif <naveedlatif786@yahoo.co.in>,
	linux-kernel@vger.kernel.org
References: <20040715035459.91164.qmail@web8201.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715035459.91164.qmail@web8201.mail.in.yahoo.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 04:54:59AM +0100, Naveed Latif wrote:
> Can any one help me regarding this issue, How I can I
> solve this problem.

Fix up rd.c so it can do mapping->gfp_mask |= GFP_HIGHUSER.


-- wli
