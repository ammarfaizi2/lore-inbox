Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbULJDxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbULJDxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 22:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbULJDxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 22:53:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:56478 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261675AbULJDx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 22:53:29 -0500
Date: Thu, 9 Dec 2004 19:53:11 -0800
From: Greg KH <greg@kroah.com>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch]Memory leak in sysfs
Message-ID: <20041210035311.GA25754@kroah.com>
References: <894E37DECA393E4D9374E0ACBBE7427013CA02@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013CA02@pdsmsx402.ccr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 10:21:58AM +0800, Zou, Nanhai wrote:
> Some stress testes show there is a memory leak in the latest kernel.
> I found the memory leak is in sysfs.
> Here is a patch against 2.6.10-rc2-mm4 to fix that.

Is this still needed against the latest -bk tree?  Adam just fixed a
leak like this recently.

And, do you have a pointer to your stress tests?  I'd love to add stuff
like this to an automated testing framework (I know OSDL has one, and
IBM has one internally.)

thanks,

greg k-h
