Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVGLLiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVGLLiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVGLLiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:38:25 -0400
Received: from coderock.org ([193.77.147.115]:47256 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261345AbVGLLgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:36:18 -0400
Date: Tue, 12 Jul 2005 13:36:06 +0200
From: Domen Puncer <domen@coderock.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
Message-ID: <20050712113606.GB2470@homer.coderock.org>
References: <20050711145616.GA22936@mellanox.co.il> <200507121012.39215.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507121012.39215.vda@ilport.com.ua>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/05 10:12 +0300, Denis Vlasenko wrote:
> > 3c. * in types
> > 	Leave space between name and * in types.
> > 	Multiple * dont need additional space between them.
> > 
> > 	struct foo **bar;
> 
> unless you declare a fuction:
> 
> int*
> function_style_for_easy_grep(...)
> {
> 	...
> }
> 
> I like this style because I can grep for ^function_style_for_easy_grep
> and quickly find function def.
> 

That's a pretty bad argument, since most functions aren't declared
that way, and there are much better source code navigational tools,
like cscope and ctags.
