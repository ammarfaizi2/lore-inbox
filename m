Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUG0F1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUG0F1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 01:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266365AbUG0F1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 01:27:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:56994 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266271AbUG0F1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 01:27:08 -0400
Date: Mon, 26 Jul 2004 20:26:25 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add kref_read and kref_put_last primitives
Message-ID: <20040726145623.GI1231@obelix.in.ibm.com>
References: <20040726144856.GH1231@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726144856.GH1231@obelix.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 08:18:56PM +0530, Ravikiran G Thirumalai wrote:
> ... 
> kref_put_last is needed sometimes when a refcount might
> have an unconventional release which needs more than
> the refcounted object to process object release-- like in the
> files_struct.f_count conversion patch at __aio_put_req().
  ^^^^^^^^^^^^^^^^^^^

Oops struct file.f_count :) sorry.

