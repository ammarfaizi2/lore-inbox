Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263111AbVHESxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263111AbVHESxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbVHESwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:52:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43229 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263100AbVHESwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:52:21 -0400
Date: Fri, 5 Aug 2005 14:50:11 -0400
From: Dave Jones <davej@redhat.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Antoine Martin <antoine@nagafix.co.uk>, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: preempt with selinux NULL pointer dereference
Message-ID: <20050805185011.GL2241@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Antoine Martin <antoine@nagafix.co.uk>,
	James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>
References: <1123234785.7889.7.camel@dhcp-192-168-22-217.internal> <Pine.LNX.4.63.0508051024100.559@excalibur.intercode> <1123260373.4471.8.camel@dhcp-192-168-22-217.internal> <Pine.LNX.4.61.0508051313050.5927@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508051313050.5927@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 01:19:40PM -0400, linux-os (Dick Johnson) wrote:
 > 
 > > tsdev                   8832  0
 >    ^^^^___ This doesen't seem to be a "standard" module. Maybe
 > it doesn't have a GPL compatible "license string".

Bzzzzzt.

(linux-2.6.12)$ grep GPL drivers/input/tsdev.c
MODULE_LICENSE("GPL");

That's the touchscreen driver.

		Dave

