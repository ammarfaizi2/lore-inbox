Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVE3Swh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVE3Swh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVE3Sw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:52:27 -0400
Received: from mail.dvmed.net ([216.237.124.58]:46315 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261255AbVE3SwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:52:11 -0400
Message-ID: <429B60CF.5060204@pobox.com>
Date: Mon, 30 May 2005 14:51:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Thonke <iogl64nx@gmail.com>
CC: Mark Lord <liml@rtr.ca>, Erik Slagter <erik@slagter.name>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299F47B.5020603@gmail.com>	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>	 <1117438192.4851.29.camel@localhost.localdomain>  <429B56CA.5080803@rtr.ca> <1117477364.3108.2.camel@localhost.localdomain> <429B5A94.6010301@rtr.ca> <429B5CD3.7080106@gmail.com>
In-Reply-To: <429B5CD3.7080106@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:
> The new ones are real SATA drives. But some PATA devices and controllers
> support TCQ.

TCQ is a poorly designed feature, and so, will only be supported on a 
very few, special host controllers.

For most people, even if they down a drive with legacy TCQ, queueing 
will -never- be supported.  For more details read 
http://linux.yyz.us/sata/software-status.html#tcq

	Jeff


