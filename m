Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137173AbREKQrl>; Fri, 11 May 2001 12:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137172AbREKQrc>; Fri, 11 May 2001 12:47:32 -0400
Received: from betty.magenta-netlogic.com ([193.37.229.181]:10759 "HELO
	betty.magenta-netlogic.com") by vger.kernel.org with SMTP
	id <S137171AbREKQrQ>; Fri, 11 May 2001 12:47:16 -0400
Message-ID: <3AFC178F.3090806@magenta-netlogic.com>
Date: Fri, 11 May 2001 17:47:11 +0100
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org, Hans Reiser <reiser@namesys.com>
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <01050910381407.26653@bugs> <20010510134453.A6816@emma1.emma.line.org> <3AFA9AD8.7080203@magenta-netlogic.com> <20010511013726.C31966@emma1.emma.line.org> <3AFBFDB0.5080904@magenta-netlogic.com> <20010511175605.G28282@burns.dt.e-technik.uni-dortmund.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

> It's probably not. vs-13048 can usually be rectified (ugly, slow but
> usually works on machines even with 256 MB RAM and 1/2 GB swap) by ls
> -laR / or treescan -stat /.


ls can't access the files either, so I don't see how that could rectify 
anything.  The entire directory becomes inaccessible.   This happened to 
/lib once.  Nasty.

I'd like to be able to use something like reiserfs, especially when 
developing (it reduces boot time a lot).  However to call it 'stable' on 
2.4.4 is simply wrong.  If/when the nfs fix gets merged and tested 
*then* it stands a chance of being called stable.


Tony


-- 
Where a calculator on the ENIAC is equpped with 18,000 vaccuum
tubes and weighs 30 tons, computers in the future may have only
1,000 vaccuum tubes and perhaps weigh 1 1\2 tons.
-- Popular Mechanics, March 1949

tmh@magenta-netlogic.com


