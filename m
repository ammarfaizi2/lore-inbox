Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbUJ1JsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbUJ1JsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUJ1JsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:48:04 -0400
Received: from ozlabs.org ([203.10.76.45]:19841 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262867AbUJ1Jn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:43:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16768.48995.829185.709615@cargo.ozlabs.ibm.com>
Date: Thu, 28 Oct 2004 19:44:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlocks on dpm_sem
In-Reply-To: <Pine.LNX.4.50.0410280142130.13935-100000@monsoon.he.net>
References: <16760.33519.670998.641860@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.50.0410280142130.13935-100000@monsoon.he.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat,

> Sorry for the long delay in responding. I don't have a problem with it,
> especially since it fixes a real problem. But, I wonder if there is a
> better way to handle devices. The multiple lists themselves seem a little
> wonky..

The multiple lists actually turned out to help in that they make it
easy to show that bad things won't happen if devices get added or
removed while we are suspending or resuming. :)

Paul.
