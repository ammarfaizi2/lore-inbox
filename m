Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVCDJrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVCDJrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVCDJrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:47:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:39626 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262668AbVCDJrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:47:18 -0500
Date: Fri, 4 Mar 2005 01:43:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: romano@dea.icai.upco.es
Cc: romanol@upco.es, miguelanxo@telefonica.net, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.11: suspending laptop makes system randomly unstable
Message-Id: <20050304014335.319b9165.akpm@osdl.org>
In-Reply-To: <20050304092333.GA11862@pern.dea.icai.upco.es>
References: <422618F0.3020508@telefonica.net>
	<20050302134342.4c9cc488.akpm@osdl.org>
	<20050304092333.GA11862@pern.dea.icai.upco.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romano Giannetti <romanol@upco.es> wrote:
>
> On Wed, Mar 02, 2005 at 01:43:42PM -0800, Andrew Morton wrote:
> > 
> > That's an ACPI problem, I assume?
> > 
> 
> Probably. There is something flaky in ACPI event (it happened sometime
> between 2.6.7 and 2.6.9, i tried to check all the patches, but I had find
> nothing. 
> 
> Could someone please check http://bugme.osdl.org/show_bug.cgi?id=4124 and
> tell me what to do to help in debugging it? 
> 
> What is very strange is why "power button" and "read battery current capacity" 
> events are working ok, and "sleep button" or "CRT switch button" or "ac
> plugged/unplugged" seems more or less random delayed. 
> 

Add acpi-devel to cc...
