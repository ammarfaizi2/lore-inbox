Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284664AbRLHUS7>; Sat, 8 Dec 2001 15:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284684AbRLHUSt>; Sat, 8 Dec 2001 15:18:49 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:25609 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284627AbRLHUSf>; Sat, 8 Dec 2001 15:18:35 -0500
Message-ID: <3C127551.90305@namesys.com>
Date: Sat, 08 Dec 2001 23:17:21 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: "Stephen C . Tweedie" <sct@redhat.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Revised extended attributes interface
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:

>
>
>In a way there's consensus wrt how to do POSIX ACLs on Linux
>now, as both the ext2/ext3 and XFS ACL projects will be using
>the same tools, libraries, etc.  In terms of other ACL types,
>I don't know of anyone actively working on any.
>
>
We are taking a very different approach to EAs (and thus to ACLs) as 
described in brief at www.namesys.com/v4/v4.html.  We don't expect 
anyone to take us seriously on it before it works, but silence while 
coding does not equal consensus.;-)

In essence, we think that if a file can't do what an EA can do, then you 
need to make files able to do more.

It is very important not to reduce the amount of closure (as in 
mathematical closure) within the namespace, and creating EAs that cannot 
be accessed as files reduces closure.

The same argument applies to streams, but it is kind of interesting to 
see people argue against streams for this reason, and then embrace EAs. 
 Kind of leaves you wondering whether their hatred of streams was really 
any deeper than streams aren't what they are used to from Unix.

Hans


