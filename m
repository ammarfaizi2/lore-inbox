Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311934AbSCTSd1>; Wed, 20 Mar 2002 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293043AbSCTSdR>; Wed, 20 Mar 2002 13:33:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31249 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311934AbSCTSdE>; Wed, 20 Mar 2002 13:33:04 -0500
Message-ID: <3C98D5CD.4000000@zytor.com>
Date: Wed, 20 Mar 2002 10:32:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020312
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: extending callbacks?
In-Reply-To: <Pine.GSO.4.44.0203191111320.20995-100000@speedy>	<a78gd7$jk$1@cesium.transmeta.com> <m1d6xzw7xf.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> ???
> 
> static void *my_fixed_arg;
> int temp_cb(int u)
> {
>         return real_cb(u, my_fixed_arg);
> }
> 
> Generally works.  The variant that builds that code on the fly for
> create_callback is a little more interesting of course.
> 

Well, of course you can do anything with a thunk.  I thought the 
question was if you can do the call *directly*.

	-hpa


