Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVCDHjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVCDHjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVCDHjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:39:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262633AbVCDHjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:39:25 -0500
Date: Fri, 4 Mar 2005 02:39:17 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: 2.6.11 vs DVB cx88 stuffs
Message-ID: <20050304073917.GA1496@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, gene.heskett@verizon.net,
	linux-kernel@vger.kernel.org, kraxel@bytesex.org
References: <200503032119.04675.gene.heskett@verizon.net> <20050303224438.2952f63e.akpm@osdl.org> <20050303231716.14a48f5f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303231716.14a48f5f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 11:17:16PM -0800, Andrew Morton wrote:

 > >  The reason this wasn't picked up is that neither `make allyesconfig' or
 > >  `make allmodconfig' enables CONFIG_VIDEO_CX88_DVB or
 > >  CONFIG_VIDEO_CX88_DVB_MODULE.
 > >
 > >  For coverage purposes it would be excellent to fix that up too, please.
 > 
 > Wise words, those.

It's dependant on CONFIG_BROKEN. Remove that, and allmodconfig should pick it up.

		Dave

