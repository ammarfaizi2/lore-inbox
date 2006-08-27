Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWH0VGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWH0VGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 17:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWH0VGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 17:06:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7405 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932258AbWH0VGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 17:06:21 -0400
Date: Sun, 27 Aug 2006 14:05:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Dong Feng <middle.fengdong@gmail.com>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
In-Reply-To: <200608272252.48946.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608271404260.22510@schroedinger.engr.sgi.com>
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
 <200608272252.48946.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006, Andi Kleen wrote:

> rwsems don't -- there are two flavours: a generic spinlock'ed one and a 
> complicated atomic based one that only works on some architectures. 
> As far as I know nobody has demonstrated a clear performance increase
> from the first so it might be possible to switch all to the generic
> implementation.

Yup that would be the major issue.I'd be interested to see some tests in 
that area.
