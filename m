Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264880AbVBDVA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbVBDVA7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbVBDUzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:55:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:40372 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266555AbVBDUwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:52:37 -0500
Date: Fri, 4 Feb 2005 12:52:26 -0800
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] tpm: implement use of sysfs classes
Message-ID: <20050204205226.GA26780@kroah.com>
References: <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com> <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com> <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com> <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com> <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com> <Pine.LNX.4.58.0501281539340.6360@jo.austin.ibm.com> <Pine.LNX.4.58.0501311322380.9872@jo.austin.ibm.com> <Pine.LNX.4.58.0502031034290.18135@jo.austin.ibm.com> <Pine.LNX.4.58.0502041405230.22211@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502041405230.22211@jo.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 02:12:50PM -0600, Kylene Hall wrote:
> +static struct class tpm_class = {
> +	.name = "tpm",
> +	.class_dev_attrs = tpm_attrs,
> +};

Where is your release function?  Did you see any warnings from the
kernel when you removed any of these class devices?  Why did you ignore
it?

thanks,

greg k-h
