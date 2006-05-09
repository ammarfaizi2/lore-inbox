Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWEIQGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWEIQGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWEIQGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:06:16 -0400
Received: from ns1.mvista.com ([63.81.120.158]:61832 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751277AbWEIQGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:06:15 -0400
Subject: Re: [RFC PATCH 03/35] Add Xen interface header files
From: Daniel Walker <dwalker@mvista.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060509085147.903310000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
	 <20060509085147.903310000@sous-sol.org>
Content-Type: text/plain
Date: Tue, 09 May 2006 09:06:12 -0700
Message-Id: <1147190772.21536.30.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (xen-interface-headers)
> Add Xen interface header files. These are taken fairly directly from
> the Xen tree and hence the style is not entirely in accordance with
> Linux guidelines. There is a tension between fitting with Linux coding
> rules and ease of maintenance.
> 
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  include/xen/interface/arch-x86_32.h   |  197 +++++++++++++++
>  include/xen/interface/event_channel.h |  205 +++++++++++++++
>  include/xen/interface/features.h      |   53 ++++
>  include/xen/interface/grant_table.h   |  311 +++++++++++++++++++++++
>  include/xen/interface/io/blkif.h      |   85 ++++++


Shouldn't these be under asm-i386 , or are they used by other
architecture ? 

Daniel

