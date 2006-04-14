Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWDNAf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWDNAf1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWDNAf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:35:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:20130 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965000AbWDNAf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:35:26 -0400
Subject: Re: Current linus git bcm4xxx broken for me
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: bcm43xx-dev@lists.berlios.de
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1144972957.5006.2.camel@localhost.localdomain>
References: <1144972957.5006.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 10:35:19 +1000
Message-Id: <1144974919.4686.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 10:02 +1000, Benjamin Herrenschmidt wrote:
> I get that with current upstream git :

  .../...

Correction: It actually works after tickling softmac a bit (it's an open
network with non advertised essid, the init scripts are supposedly
setting the essid but softmac is having some vapors, changing the essid
manually a couple of times and it ends up associating).

Still, the dmesg filling up with those messages is pretty nasty :)

Ben.


