Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVEZTu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVEZTu4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 15:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVEZTuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 15:50:55 -0400
Received: from mail.dvmed.net ([216.237.124.58]:16603 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261718AbVEZTuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 15:50:52 -0400
Message-ID: <42962895.3020504@pobox.com>
Date: Thu, 26 May 2005 15:50:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ross Biro <ross.biro@gmail.com>
CC: Jim Gifford <maillist@jg555.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Random IDE Lock ups with via IDE
References: <4293B859.3070609@jg555.com> <4294BAE8.5050803@jg555.com>	 <8783be6605052513343fce843b@mail.gmail.com>	 <4294E409.9020907@jg555.com>	 <8783be6605052516577daeebdf@mail.gmail.com>	 <42961567.1010906@jg555.com> <8783be6605052612354c09ab8b@mail.gmail.com>
In-Reply-To: <8783be6605052612354c09ab8b@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro wrote:
> problem.  A drive vendor once told me that it could take more than a
> minute for an IDE drive to complete a command.  I no longer purchase
> drives from that vendor.


All vendors could potentially take more than 30 seconds to complete ATA 
commands such as FLUSH CACHE EXT, in extreme cases.

	Jeff


