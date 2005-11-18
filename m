Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbVKRDTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbVKRDTM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVKRDTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:19:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1671 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751421AbVKRDTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:19:10 -0500
Date: Thu, 17 Nov 2005 22:17:51 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20051118031751.GA2773@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20051118014055.GK11494@stusta.de> <20051117175015.6aa99fcf.akpm@osdl.org> <20051118020640.GM11494@stusta.de> <20051117182047.5fe1a5eb.akpm@osdl.org> <20051118024433.GN11494@stusta.de> <20051117185529.31d33192.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117185529.31d33192.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 06:55:29PM -0800, Andrew Morton wrote:

 > > IMHO the warnings are the best solution for getting a vast amount fixed, 
 > > and then it's time to think about the rest.
 > 
 > But the warnings don't *work*.  I'm *still* staring at stupid pm_register
 > and intermodule_foo warnings.  How long has that been?

Too long.  I think the mtd stuff won't ever get fixed until after that
function gets removed.

		Dave
