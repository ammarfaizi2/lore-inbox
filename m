Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317362AbSHBAXC>; Thu, 1 Aug 2002 20:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317363AbSHBAXC>; Thu, 1 Aug 2002 20:23:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33034 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317362AbSHBAW7>;
	Thu, 1 Aug 2002 20:22:59 -0400
Message-ID: <3D49D1B2.2010201@mandrakesoft.com>
Date: Thu, 01 Aug 2002 20:26:26 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <movement@marcelothewonderpenguin.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: network driver informations [general NIC, Wireless and e100]
References: <20020731212426.GA3342@schottelius.org> <3D492531.9030905@mandrakesoft.com> <20020801174252.GA58488@compsoc.man.ac.uk>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
> On Thu, Aug 01, 2002 at 08:10:25AM -0400, Jeff Garzik wrote:
> 
> 
>>Al Viro has talked about, long term, making this information available 
>>through a filesystem.  When that happens, your request will have 
>>basically been implemented.
> 
> 
> It would probably help if some of the basic code needed was wrapped in
> an even more "dumbed-down" API - most of the stuff in say pcihpfs is
> generically useful for this sort of configfs thing.
> 
> As more and more minifs's appear (they are trivially easy to write after
> all) we're likely to see more duplication of this code, and the
> resultant missing bug fix propogation


Doubtful -- Al Viro created libfs.c, and understands the basic concept 
of avoiding code duplication :)


