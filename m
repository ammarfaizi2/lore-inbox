Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312223AbSCRHFY>; Mon, 18 Mar 2002 02:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312222AbSCRHFE>; Mon, 18 Mar 2002 02:05:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63242 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312221AbSCRHEy>;
	Mon, 18 Mar 2002 02:04:54 -0500
Message-ID: <3C959172.5080309@mandrakesoft.com>
Date: Mon, 18 Mar 2002 02:04:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Anton Blanchard <anton@samba.org>, Gerrit Huizenga <gh@us.ibm.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] 7.52 second kernel compile
In-Reply-To: <20020316061535.GA16653@krispykreme> <E16m7u7-0007yv-00@w-gerrit2> <20020317123434.GE22387@krispykreme> <20020317170955.A491@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:

>On Sun, Mar 17, 2002 at 11:34:34PM +1100, Anton Blanchard wrote:
>
>>>And this *without* the dcache_lock?  Hmm.  So you are saying there
>>>may still be room for improvement?
>>>
>>I tried the dcache lock patches but found it hard to see a difference,
>>for us the mm stuff still seems to be the bottleneck.
>>
>
>Try the patch which gets rid of the BKL in ext2_get_block() --- if you
>don't have that, let me know, I've got one kicking around that mostly
>works except I haven't validated that it does the right thing if
>quotas are enabled.
>

Is yours different from what's in 2.5.x?

    Jeff






