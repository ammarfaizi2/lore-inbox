Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUCZDxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbUCZDxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:53:36 -0500
Received: from waste.org ([209.173.204.2]:1709 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263923AbUCZDxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:53:34 -0500
Date: Thu, 25 Mar 2004 21:53:31 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/22] /dev/random: remove broken resizing sysctl
Message-ID: <20040326035331.GD8366@waste.org>
References: <3.524465763@selenic.com> <4.524465763@selenic.com> <20040325161523.3efbb4b7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325161523.3efbb4b7.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 04:15:23PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > /dev/random  remove broken resizing sysctl
> 
> This could break things.  Shouldn't we leave the /proc entry there
> and print a friendly message in the sysctl handler?

I could do that, yes. I would be really surprised if there were any
users, however.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
