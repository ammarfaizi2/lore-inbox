Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUJVV0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUJVV0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267869AbUJVVW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:22:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:63705 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268000AbUJVVE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:04:58 -0400
Date: Fri, 22 Oct 2004 14:04:09 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] avoid problems with kobject_set_name and name with %
Message-ID: <20041022210409.GB25042@kroah.com>
References: <20041008113333.5e6e5d3e@zqx3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008113333.5e6e5d3e@zqx3.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 11:33:33AM -0700, Stephen Hemminger wrote:
> kobject_set_name takes a printf style argument list. There are many
> callers that pass only one string, if this string contained a '%' character
> than bad things would happen.  The fix is simple.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Applied, thanks.

greg k-h
