Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263216AbSJCL6x>; Thu, 3 Oct 2002 07:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263238AbSJCL6w>; Thu, 3 Oct 2002 07:58:52 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:60432 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S263216AbSJCL6v>; Thu, 3 Oct 2002 07:58:51 -0400
Message-ID: <3D9C323C.1050504@namesys.com>
Date: Thu, 03 Oct 2002 16:04:12 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on
 2.5.40-mm1
References: <20021001195914.GC6318@stingr.net> <20021001204330.GO3000@clusterfs.com> <20021002104859.GD6318@stingr.net> <20021002165454.GV3000@clusterfs.com> <20021003003739.GA4381@think.thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>  
>
>Just to be clear, the limit which Paul is referring to is just simply
>a matter of creating the filesystem with a sufficient number of
>inodes.  (i.e., mke2fs -N 1200000).  Yes, having a dynamic inode table
>would be good, but in practice sysadmins know how many inodes are
>needed in advance.
>
>						- Ted
>
>  
>

No they don't.  Average space wastage is more than 50% because sysadmins 
have to be conservative.

Hans

