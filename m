Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVBSEpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVBSEpQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 23:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVBSEpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 23:45:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19142 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261344AbVBSEpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 23:45:11 -0500
Date: Fri, 18 Feb 2005 23:45:09 -0500
From: Dave Jones <davej@redhat.com>
To: Marc Cramdal <marc.cramdal@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sis760 chipset support
Message-ID: <20050219044509.GC22148@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marc Cramdal <marc.cramdal@gmail.com>, linux-kernel@vger.kernel.org
References: <4213AB2B.2050604@giesskaennchen.de> <200502181907.16586.marc.cramdal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502181907.16586.marc.cramdal@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 07:07:16PM +0100, Marc Cramdal wrote:
 > Hello,
 > 
 > I can't make agpgart working (even when trying the agp_try_unsupported) 
 > option. I have an AMD64 3000+ with a Sis760 chipset and agp doesn't seem to 
 > be supported : I only get this with dmesg : "Linux agpgart interface v0.100 
 > (c) Dave Jones". That's all...
 > 
 > So, is Sis760 chipset supported for agpgart under linux kernel ? if not, is 
 > there plan to be, tweaks to do (I even tried the Sis Chipset driver 
 > for !x86_64 by removing this entry in KConfig ... ) ?
 > 

amd64 should be using the amd64-agp driver, as your agpgart is on-cpu
on that platform.

		Dave

