Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbVLOJOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbVLOJOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbVLOJOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:14:06 -0500
Received: from ns.firmix.at ([62.141.48.66]:42420 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1161150AbVLOJOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:14:04 -0500
Subject: Re: Question
From: Bernd Petrovitsch <bernd@firmix.at>
To: nramirez@site.uottawa.ca
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3374.127.0.0.1.1134603734.squirrel@127.0.0.1>
References: <3374.127.0.0.1.1134603734.squirrel@127.0.0.1>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 15 Dec 2005 10:13:49 +0100
Message-Id: <1134638030.26870.24.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 18:42 -0500, nramirez@site.uottawa.ca wrote:
[...]
> I want to implement a congestion control algorithm for an Ad-hoc wireless
> network. It means i will make some modifications to TCP and therefore in
> the transport layer.
> Do i need to modify the Kernel to do my implementation? or there are some

Yes.

> kernel modules i can modify as for the case of implementing a routing
> protocol in the network layer? If both are possible what could be the

No. You can compile the TCP/IP stack as module for easier
loading/unloading but that's all.

> advantage or disadvantage of each? Where can i get more information?

BTW almost rotuing protocols don't need changes in TCP/IP - they simple
use it as is and configure routes from the outside (of the kernel).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

