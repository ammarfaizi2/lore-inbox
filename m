Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbREEOmj>; Sat, 5 May 2001 10:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132589AbREEOma>; Sat, 5 May 2001 10:42:30 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:16904 "HELO
	zcamail05.zca.compaq.com") by vger.kernel.org with SMTP
	id <S132586AbREEOmK>; Sat, 5 May 2001 10:42:10 -0400
Message-ID: <3AF4118F.330C3E86@zk3.dec.com>
Date: Sat, 05 May 2001 10:43:27 -0400
From: Peter Rival <frival@zk3.dec.com>
X-Mailer: Mozilla 4.6 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
In-Reply-To: <20010505063726.A32232@va.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone looked into memory hot swap/hot add support?  Especially with
systems with Chipkill coming out, this would be great to support...

 - Pete

Anton Blanchard wrote:

> Hi,
>
> You can find a new version of the hot swap cpu patch at:
>
> http://samba.org/~anton/patches/cpu_hotswap-2.4.3-patch
>
> The version for s390 (you need to first apply the 2.4.3 kernel
> patch available on the IBM s390 Linux website) is at:
>
> http://samba.org/~anton/patches/cpu_hotswap-2.4.3-patch-s390
>
> Many thanks to Heiko Carstens <Heiko.Carstens@de.ibm.com> for adding
> s390 support and fixing a few bugs in the initial implementation.
> You should be able to attach and detach CPUs depending on workload
> in your s390 Linux guest images :)
>
> One of the advantages of this patch is that it removes cpu_logical_map()
> and cpu_number_map() which people had a tendency to get wrong.
>
> It should also be easy to support more than BITS_PER_LONG cpus
> as there is no concept of online_cpu_map any more.
>
> Anton
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

