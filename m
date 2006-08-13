Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWHMOpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWHMOpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 10:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWHMOpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 10:45:05 -0400
Received: from ozlabs.org ([203.10.76.45]:27857 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751264AbWHMOpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 10:45:03 -0400
Date: Mon, 14 Aug 2006 00:44:00 +1000
From: Anton Blanchard <anton@samba.org>
To: Thomas Klein <osstklei@de.ibm.com>
Cc: Jan-Bernd Themann <themann@de.ibm.com>,
       Jan-Bernd Themann <ossthema@de.ibm.com>,
       netdev <netdev@vger.kernel.org>, linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>, roland@topspin.com
Subject: Re: [PATCH 3/6] ehea: queue management
Message-ID: <20060813144400.GJ479@krispykreme>
References: <44D99F38.8010306@de.ibm.com> <20060811215225.GH479@krispykreme> <44DE03B0.1060607@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44DE03B0.1060607@de.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> I agree, stubbs were removed.

Thanks.

What is going to be done about the debug infrastructure in the ehea
driver? The entry and exit traces really need to go, and any other debug
you think is important to users needs to go into debugfs or something
similar.

I see a similar issue in the ehca driver that I am in the middle of
reviewing.

Anton
