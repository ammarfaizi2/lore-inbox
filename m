Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWEXT7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWEXT7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 15:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWEXT7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 15:59:13 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:21149 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751144AbWEXT7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 15:59:12 -0400
Subject: Re: + spin-rwlock-init-cleanups.patch added to -mm tree
From: Dave Hansen <haveblue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, arjan@linux.intel.com
In-Reply-To: <200605241944.k4OJiSVk028716@shell0.pdx.osdl.net>
References: <200605241944.k4OJiSVk028716@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 24 May 2006 12:59:03 -0700
Message-Id: <1148500743.8658.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 12:47 -0700, akpm@osdl.org wrote:
> -       freeIPIq.lock = SPIN_LOCK_UNLOCKED;
> +       spin_lock_init(&freeIPIq.lock ); 

There are a bunch of spaces in some of the the function calls.  Didn't
know if anybody noticed...

-- Dave

