Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136514AbREJNnO>; Thu, 10 May 2001 09:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136505AbREJNnE>; Thu, 10 May 2001 09:43:04 -0400
Received: from betty.magenta-netlogic.com ([193.37.229.181]:31251 "HELO
	betty.magenta-netlogic.com") by vger.kernel.org with SMTP
	id <S136538AbREJNmv>; Thu, 10 May 2001 09:42:51 -0400
Message-ID: <3AFA9AD8.7080203@magenta-netlogic.com>
Date: Thu, 10 May 2001 14:42:48 +0100
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.8.1+) Gecko/20010423
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <01050910381407.26653@bugs> <20010510134453.A6816@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

> ext3fs has never given me any problems, but I did not have it in
> production use where I discovered major ReiserFS <-> kNFSd
> incompatibilities. ext3 has a 0.0.x version number which suggests it's
> not meant for production use. 

Hmm... Reiserfs is incompatible with knfsd?  That might explain the 
massive data loss I was getting with reiserfs (basically I'd have to 
reformat and reinstall every couple of weeks).  The machine this was 
happening with also exports my apt cache for the rest of the network.

Tony

-- 
Where a calculator on the ENIAC is equpped with 18,000 vaccuum
tubes and weighs 30 tons, computers in the future may have only
1,000 vaccuum tubes and perhaps weigh 1 1\2 tons.
-- Popular Mechanics, March 1949

tmh@magenta-netlogic.com


