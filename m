Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTFFLxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 07:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTFFLxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 07:53:33 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:24837 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261245AbTFFLxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 07:53:33 -0400
Date: Fri, 6 Jun 2003 16:06:35 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI cache line messages 2.4/2.5
Message-ID: <20030606160635.A2743@jurassic.park.msu.ru>
References: <5.1.0.14.2.20030605172023.05514098@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20030605172023.05514098@pop.t-online.de>; from margitsw@t-online.de on Thu, Jun 05, 2003 at 05:23:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 05:23:54PM +0200, Margit Schubert-While wrote:
> With what (if any) consequences under 2.4 ?
> Shouldn't it be fixed for 2.4.21 ?

More likely for early 2.4.22-pre. In the worst case you'd
end up enabling MWI with cacheline size = 0, which
should be a no-op on any sane hardware.

Ivan.
