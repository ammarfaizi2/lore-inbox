Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWHHQiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWHHQiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWHHQiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:38:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28624 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964984AbWHHQh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:37:59 -0400
Date: Tue, 8 Aug 2006 12:36:35 -0400
From: Dave Jones <davej@redhat.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Muli Ben-Yehuda <muli@il.ibm.com>,
       =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, dev@openvz.org, stable@kernel.org
Subject: Re: + sys_getppid-oopses-on-debug-kernel.patch added to -mm tree
Message-ID: <20060808163635.GF28990@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Kirill Korotaev <dev@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Muli Ben-Yehuda <muli@il.ibm.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	linux-kernel@vger.kernel.org, dev@openvz.org, stable@kernel.org
References: <200608081432.k78EWprf007511@shell0.pdx.osdl.net> <20060808143937.GA3953@rhun.haifa.ibm.com> <20060808145138.GA2720@atjola.homenet> <20060808145709.GB3953@rhun.haifa.ibm.com> <1155050547.5729.91.camel@localhost.localdomain> <44D8B048.8060103@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D8B048.8060103@sw.ru>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 07:39:52PM +0400, Kirill Korotaev wrote:
 > >>Even without getting into just how ugly this is, is it really worth
 > >>it?
 > it is impossible to run debug kernels w/o this patch :/
 > or are you asking whether this optimization worth it?
 > 
 > What makes me worry is that this is a sign that vendors
 > don't even bother to run debug kernels :((((

Fedora rawhide is nearly always shipping with DEBUG_SLAB enabled,
and we didn't hit this once.  Are you sure this is a problem
with DEBUG_SLAB, and not DEBUG_PAGEALLOC ?

		Dave

-- 
http://www.codemonkey.org.uk
