Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbTJPVZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTJPVZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:25:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22992 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263122AbTJPVZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:25:20 -0400
Message-ID: <3F8F0CB2.7050002@pobox.com>
Date: Thu, 16 Oct 2003 17:25:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Meadors <clubneon@hereintown.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove>	 <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com>	 <20031016162926.GF1663@velociraptor.random>	 <20031016172930.GA5653@work.bitmover.com>	 <20031016174927.GB25836@speare5-1-14>  <3F8F0766.30405@pobox.com> <1066339127.3958.8.camel@clubneon.priv.hereintown.net>
In-Reply-To: <1066339127.3958.8.camel@clubneon.priv.hereintown.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors wrote:
> On Thu, 2003-10-16 at 17:02, Jeff Garzik wrote:
> 
> 
>>I'm curious if anyone has done any work on using multiple different 
>>checksums?  For example, the cost of checksumming a single block with 
>>multiple algorithms (sha1+md5+crc32 for a crazy example), and storing 
>>each checksum (instead of just one sha1 sum), may be faster than reading 
>>the block off of disk to compare it with the incoming block.  OTOH, 
>>there is still a mathematical possibility (however-more-remote) of a 
>>collission...
> 
> 
> I don't think multiple hashes will gain any more uniqueness over just a
> larger hash value. 

I disagree...

  But as long as the hash is smaller than the block
> being hashed there is the possibility of two dissimilar blocks producing
> the same hash.

Agreed.

	Jeff



