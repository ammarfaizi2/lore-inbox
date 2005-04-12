Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVDLIoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVDLIoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVDLIoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:44:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:39592 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262059AbVDLInx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:43:53 -0400
Date: Tue, 12 Apr 2005 01:43:25 -0700
From: Greg KH <greg@kroah.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prototype error in <linux/debugfs.h>
Message-ID: <20050412084324.GA5028@kroah.com>
References: <200504120835.j3C8Zmg06782@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504120835.j3C8Zmg06782@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 01:35:51AM -0700, Chen, Kenneth W wrote:
> To lazy to write a patch, the inline debugfs function declaration
> for the following three functions disagree between CONFIG_DEBUG_FS
> and !CONFIG_DEBUG_FS
> 
> 4th argument mismatch, looks like an obvious copy-n-paste error.
> u16, u32, and u32?

Already fixed in the -mm tree, patch is queued to be sent to Linus, once
he starts accepting patches again.

thanks,

greg k-h
