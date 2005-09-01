Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbVIAUTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbVIAUTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbVIAUTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:19:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18683 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1030361AbVIAUTn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:19:43 -0400
Subject: Re: [PATCH 2.6.13] Unhandled error condition in aic79xx
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050901201029.GA10893@mipter.zuzino.mipt.ru>
References: <1125603501.4867.21.camel@dhcp153.mvista.com>
	 <20050901201029.GA10893@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 01 Sep 2005 13:19:38 -0700
Message-Id: <1125605978.4867.30.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 00:10 +0400, Alexey Dobriyan wrote:

> I see malloc(), kernel_thread() and multiple ahd_linux_alloc_target()
> above. Ditto for 7xxx patch.
> 

True, no wonder this condition hasn't been handled yet..

Daniel

