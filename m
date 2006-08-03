Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbWHCQuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWHCQuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHCQuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:50:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932085AbWHCQuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:50:15 -0400
Date: Thu, 3 Aug 2006 09:50:12 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Sean Bruno <sean.bruno@dsl-only.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sk98lin extremely slow transfer rate ASUS P5P800(2.6.17.7)
Message-ID: <20060803095012.237afddb@localhost.localdomain>
In-Reply-To: <1154623596.6485.17.camel@home-desk>
References: <1154619601.6485.15.camel@home-desk>
	<20060803094009.5f027226@localhost.localdomain>
	<1154623596.6485.17.camel@home-desk>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2006 09:46:36 -0700
Sean Bruno <sean.bruno@dsl-only.net> wrote:

> On Thu, 2006-08-03 at 09:40 -0700, Stephen Hemminger wrote:
> > skge
> 
> I am using sk98lin under 2.6.17.7 ... should I give skge a shot?
> 
> Sean
> 

Yes, we will fix skge, sk98lin probably will stay busted...

You might be seeing checksum errors or flow control issues.

Look at ethtool stats (ethtool -S eth0) 
and try with hardware checksumming off (ethtool -K rx off tx off)


-- 
