Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUELWoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUELWoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUELWoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:44:55 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:16104 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S262176AbUELWoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:44:54 -0400
Date: Wed, 12 May 2004 18:44:54 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>,
       Sridhar Samudrala <sri@us.ibm.com>, davem@redhat.com,
       George Anzinger <george@mvista.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512224454.GJ21953@ti64.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
	linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>,
	Sridhar Samudrala <sri@us.ibm.com>, davem@redhat.com,
	George Anzinger <george@mvista.com>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512205407.GD25515@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512205407.GD25515@ti64.telemetry-investments.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 04:54:07PM -0400, Bill Rugolsky Jr. wrote:
> The attached patch combines Sridhar's consolidation patch with my
> more accurate routines in the spirit of the rest of time.h.  It is against
> 2.6.6-rc3-bk3.  Feedback welcome.  I'm happy to rediff against latest kernel,
> I just haven't had time the last few days.
 
Sorry to reply to myself, but please ignore the patch that I sent;
upon reflection, the 64-bit logic is (still) wrong.

	Bill Rugolsky
