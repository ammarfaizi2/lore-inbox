Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUCBH6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 02:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUCBH6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 02:58:41 -0500
Received: from waste.org ([209.173.204.2]:7391 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261505AbUCBH6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 02:58:40 -0500
Date: Tue, 2 Mar 2004 01:58:26 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org
Subject: Re: FASTBOOT options in EMBEDDED menu?
Message-ID: <20040302075826.GX3883@waste.org>
References: <40438CDB.9080003@am.sony.com> <20040301112435.66be3bcc.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040301112435.66be3bcc.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 11:24:35AM -0800, Randy.Dunlap wrote:
> On Mon, 01 Mar 2004 11:19:55 -0800 Tim Bird wrote:
> 
> | I'm starting to adapt some patches for options which
> | allow Linux to boot faster (for embedded environments).
> | 
> | It seems like these should go under the EMBEDDED
> | menu.  However, this menu looks like it is specific
> | to size reductions:
> | 
> | menuconfig EMBEDDED
> |      bool "Remove kernel features (for embedded systems)"
> |      help
> |        This option allows certain base kernel features to be removed from
> |        the build...
> | 
> | Some of the options that CELF is working on for
> | fast booting do remove features, but some do not.
> | 
> | Anyone have advice for whether I should:
> | 1) use the existing EMBEDDED option (my preference), or
> | 2) make a new FASTBOOT option?
> 
> I agree with you, EMBEDDED should be able to handle it.

I've renamed the EMBEDDED menu in my tree to something on the order of
"modify standard feature set" as it's not really specific to EMBEDDED.

Tim, if you want to send me your fastboot patches, I'd be happy to put
them in -tiny.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
