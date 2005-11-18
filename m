Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVKREMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVKREMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 23:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVKREMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 23:12:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51357 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932413AbVKREMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 23:12:43 -0500
Date: Thu, 17 Nov 2005 23:11:14 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20051118041114.GA30117@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	"David S. Miller" <davem@davemloft.net>, bunk@stusta.de,
	linux-kernel@vger.kernel.org
References: <20051118024433.GN11494@stusta.de> <20051117185529.31d33192.akpm@osdl.org> <20051118031751.GA2773@redhat.com> <20051117.194239.37311109.davem@davemloft.net> <20051117200354.6acb3599.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117200354.6acb3599.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 08:03:54PM -0800, Andrew Morton wrote:
 > "David S. Miller" <davem@davemloft.net> wrote:
 > >
 > > The deprecated warnings are so easy to filter out, so I don't think
 > >  noise is a good argument.  I see them all the time too.
 > 
 > That works for you and me.  But how to train all those people who write
 > warny patches?

Lots of poking with pointy sticks.  And -Werror.
(Just kidding, except for the bit about the sticks).

Seriously, you've caught me out pretty quickly after I've introduced
warnings in cpufreq/agpgart, for which I'm thankful. This does put
extra pressure on you though, and you've got better things to be
doing than sending nag emails.

		Dave

