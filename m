Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137150AbREKO5R>; Fri, 11 May 2001 10:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136938AbREKO5H>; Fri, 11 May 2001 10:57:07 -0400
Received: from betty.magenta-netlogic.com ([193.37.229.181]:37899 "HELO
	betty.magenta-netlogic.com") by vger.kernel.org with SMTP
	id <S137150AbREKO4w>; Fri, 11 May 2001 10:56:52 -0400
Message-ID: <3AFBFDB0.5080904@magenta-netlogic.com>
Date: Fri, 11 May 2001 15:56:48 +0100
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.8.1+) Gecko/20010423
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <01050910381407.26653@bugs> <20010510134453.A6816@emma1.emma.line.org> <3AFA9AD8.7080203@magenta-netlogic.com> <20010511013726.C31966@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

> You're not getting data loss, but access denied, when hitting
> incompatibilities, and it looks like it hits 2.2 hard while 2.4 is less
> of a problem. Please search the reiserfs list archives for details.
> vs-13048 is a good search term, I believe.

Data is lost:

Root can't access the files.
Reiserfsck can't repair the files.
The files that are corrupted are unrelated to the ones exported over NFS 
(which makes me wonder if it's the same bug).

File corruption would begin a couple of hours after the volume was 
formatted, and become catastrophic within a couple of days.

Until the fix is merged I'm not going within 100 miles of reiserfs!

Tony

-- 
Where a calculator on the ENIAC is equpped with 18,000 vaccuum
tubes and weighs 30 tons, computers in the future may have only
1,000 vaccuum tubes and perhaps weigh 1 1\2 tons.
-- Popular Mechanics, March 1949

tmh@magenta-netlogic.com


