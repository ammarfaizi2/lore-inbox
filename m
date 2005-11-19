Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVKSAkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVKSAkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 19:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVKSAkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 19:40:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43403 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751132AbVKSAkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 19:40:36 -0500
Date: Fri, 18 Nov 2005 19:39:08 -0500
From: Dave Jones <davej@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20051119003908.GK3881@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	"David S. Miller" <davem@davemloft.net>, bunk@stusta.de,
	linux-kernel@vger.kernel.org
References: <20051118024433.GN11494@stusta.de> <20051117185529.31d33192.akpm@osdl.org> <20051118031751.GA2773@redhat.com> <20051117.194239.37311109.davem@davemloft.net> <20051117200354.6acb3599.akpm@osdl.org> <20051119003435.GA29775@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119003435.GA29775@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 01:34:35AM +0100, Sam Ravnborg wrote:
 > On Thu, Nov 17, 2005 at 08:03:54PM -0800, Andrew Morton wrote:
 > > "David S. Miller" <davem@davemloft.net> wrote:
 > > >
 > > > The deprecated warnings are so easy to filter out, so I don't think
 > > >  noise is a good argument.  I see them all the time too.
 > > 
 > > That works for you and me.  But how to train all those people who write
 > > warny patches?
 > 
 > Would it work to use -Werror only on some parts of the kernel.
 > Thinking of teaching kbuild to recursively apply a flags to gcc.

Only if you also add a load of gcc switches to disable some
of the more pointless warnings, and also can live with released
kernels breaking each time a new gcc gets released.

It's an uphill battle, which is why I only suggested it in
a humourous context.

		Dave

