Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293032AbSB1Mvb>; Thu, 28 Feb 2002 07:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293342AbSB1MtB>; Thu, 28 Feb 2002 07:49:01 -0500
Received: from h24-83-222-158.vc.shawcable.net ([24.83.222.158]:45457 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S293306AbSB1MsB>;
	Thu, 28 Feb 2002 07:48:01 -0500
Message-ID: <3C7E26E7.9090100@bcgreen.com>
Date: Thu, 28 Feb 2002 04:47:35 -0800
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Big file support  (emperical evidence)
In-Reply-To: <E16gAj8-0005kb-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree -- and I was actually surprised.  On Tuesday I wrote
a script that created some huge files on an ext3 filesystem, expecting
it to die at 2GB, but it didn't die until I passed 8GB (and filled
the partition). (( redhat 7.2 ))

Alan Cox wrote:
>>A lot of the kernel supports big files already.  The real problem is the
>>fact that the primary Linux file system, ext3, does not.  If you use some
>>file system besides ext3, big files should work.
> 
> This is incorrect information. Ext3 supports large files. Whoever told
> you otherwise was wrong.


-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

