Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUDQDOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 23:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUDQDOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 23:14:45 -0400
Received: from ozlabs.org ([203.10.76.45]:27832 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262027AbUDQDOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 23:14:44 -0400
Subject: Re: module_param() doesn't seem to work in 2.6.6-rc1
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Roskin <proski@gnu.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404161735560.5025@marabou.research.att.com>
References: <Pine.LNX.4.58.0404161735560.5025@marabou.research.att.com>
Content-Type: text/plain
Message-Id: <1082171676.1390.2.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 13:14:37 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 08:24, Pavel Roskin wrote:
> Hello!
> 
> I know that module_param is supposed to obsolete MODULE_PARM in 2.6
> kernels.  However, module_param doesn't seem to work in Linux 2.6.6-rc1 (I
> didn't test older kernels, so I don't know if it's a new bug).

You can't mix old and new: only the old will work in that case.

Sorry for the confusion,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

