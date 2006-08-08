Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbWHHO5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWHHO5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWHHO5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:57:13 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:43450 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932598AbWHHO5M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:57:12 -0400
Date: Tue, 8 Aug 2006 17:57:09 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, dev@openvz.org, stable@kernel.org
Subject: Re: + sys_getppid-oopses-on-debug-kernel.patch added to -mm tree
Message-ID: <20060808145709.GB3953@rhun.haifa.ibm.com>
References: <200608081432.k78EWprf007511@shell0.pdx.osdl.net> <20060808143937.GA3953@rhun.haifa.ibm.com> <20060808145138.GA2720@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060808145138.GA2720@atjola.homenet>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 04:51:38PM +0200, Björn Steinbrink wrote:

> There's a note right above the function that explains it:
>  * NOTE! This depends on the fact that even if we _do_
>  * get an old value of "parent", we can happily dereference
>  * the pointer (it was and remains a dereferencable kernel pointer
>  * no matter what): we just can't necessarily trust the result
>  * until we know that the parent pointer is valid.

Even without getting into just how ugly this is, is it really worth
it?

Cheers,
Muli
