Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVE3Sym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVE3Sym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVE3Swn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:52:43 -0400
Received: from mail.dvmed.net ([216.237.124.58]:43755 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261676AbVE3SuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:50:22 -0400
Message-ID: <429B6060.1010806@pobox.com>
Date: Mon, 30 May 2005 14:50:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Slagter <erik@slagter.name>
CC: Mark Lord <liml@rtr.ca>, Michael Thonke <iogl64nx@gmail.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299F47B.5020603@gmail.com>	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>	 <1117438192.4851.29.camel@localhost.localdomain>  <429B56CA.5080803@rtr.ca> <1117477364.3108.2.camel@localhost.localdomain>
In-Reply-To: <1117477364.3108.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Slagter wrote:
> I must have been fooled by the FC3 setup disk that handed it libata,  I
> didn't know libata also handles pata, then.

libata software supports PATA, but no distribution ships with libata 
PATA support enabled (nor should they!).

There are a few unusual cases with combined mode where libata will 
support PATA, but those are rare.

	Jeff


