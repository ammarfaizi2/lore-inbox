Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752283AbWCKBRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbWCKBRF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 20:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbWCKBRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 20:17:05 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61855
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752283AbWCKBRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 20:17:03 -0500
Date: Fri, 10 Mar 2006 17:17:08 -0800 (PST)
Message-Id: <20060310.171708.30728745.davem@davemloft.net>
To: shemminger@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Router stops routing after changing MAC Address
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060310163958.1215b0c4@localhost.localdomain>
References: <925A849792280C4E80C5461017A4B8A20321CC@mail733.InfraSupportEtc.com>
	<20060310163958.1215b0c4@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Fri, 10 Mar 2006 16:39:58 -0800

> You probably just need to flush the route cache after the address change?

It's probably a good idea for the routing cache to catch
this event, if that's all that needs to be done.
