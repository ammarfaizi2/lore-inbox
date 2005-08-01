Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVHAIMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVHAIMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVHAIMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:12:47 -0400
Received: from ozlabs.org ([203.10.76.45]:65253 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262039AbVHAIME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:12:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17133.55525.179771.646219@cargo.ozlabs.ibm.com>
Date: Mon, 1 Aug 2005 18:10:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Nathan Lynch <ntl@pobox.com>, lkml <linux-kernel@vger.kernel.org>,
       colpatch@us.ibm.com, Anton Blanchard <anton@samba.org>
Subject: Re: topology api confusion
In-Reply-To: <20050801050748.GB31199@krispykreme>
References: <20050722213316.GE17865@otto>
	<20050801050748.GB31199@krispykreme>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard writes:

> Dont include asm-generic/topology.h unconditionally, we end up
> overriding all the ppc64 specific functions when NUMA is on.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Paul Mackerras <paulus@samba.org>

It looks like this should go into 2.6.13.
