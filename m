Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267754AbUHUUJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267754AbUHUUJw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUHUUJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:09:52 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63683 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267759AbUHUUJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:09:46 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] shows Active/Inactive on per-node meminfo
Date: Sat, 21 Aug 2004 16:09:02 -0400
User-Agent: KMail/1.6.2
Cc: amgta@yacht.ocn.ne.jp, linux-kernel@vger.kernel.org, colpatch@us.ibm.com
References: <200408210302.25053.amgta@yacht.ocn.ne.jp> <200408201501.31542.jbarnes@engr.sgi.com> <20040820152551.03a4aee7.akpm@osdl.org>
In-Reply-To: <20040820152551.03a4aee7.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408211609.02869.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 6:25 pm, Andrew Morton wrote:
> So was that an ack, a nack or a quack?

Ack.  It looks ok to me, it just reminded me that /proc/meminfo will hurt a 
lot on a big machine, but this patch messes with /sys/.../nodeX/meminfo, so 
it's fine with me, and is in fact quite useful.

Jesse
