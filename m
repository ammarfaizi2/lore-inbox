Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSIEAbr>; Wed, 4 Sep 2002 20:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSIEAbq>; Wed, 4 Sep 2002 20:31:46 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:52998 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S315746AbSIEAbq>; Wed, 4 Sep 2002 20:31:46 -0400
Message-ID: <3D76A6FF.509@namesys.com>
Date: Thu, 05 Sep 2002 04:36:15 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: shaggy@austin.ibm.com, szepe@pinerecords.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com, green@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
References: <200209042018.g84KI6612079@shaggy.austin.ibm.com>	<3D766DA8.9030207@namesys.com> <20020904.163515.82835380.davem@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>   From: Hans Reiser <reiser@namesys.com>
>   Date: Thu, 05 Sep 2002 00:31:36 +0400
>
>   The proper fix should be to make the result of the limit
>   computation be accurately architecture specific.
>
>And then each and every Reiserfs partition is platform specific
>and cannot be mounted onto another Linux platform.
>
>Creating such a restriction is a grave error.
>
>
>  
>
And you would cripple the 99% usage to aid those users who move disk 
drives physically over to a sparc box AND have more than 31k links to a 
file?

Or is there some usage pattern that I don't appreciate that makes it 
highly likely that people will swap disks into a sparc?  Maybe these hot 
plug ruggedized with plastic covers IDE disks that there was some press 
about being a substitute for DVDs a few months ago?

Frankly, I had doubts about our code that causes CPU order to not be 
used in the disk format, but I was persuaded that it was not a 
measurable performance loss to do it and said yes.

I recognize that you may see things from a perspective that I have not 
experienced, so please articulate on that if so.

Hans

