Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318425AbSGaVij>; Wed, 31 Jul 2002 17:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318466AbSGaVij>; Wed, 31 Jul 2002 17:38:39 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:999 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S318425AbSGaVii>; Wed, 31 Jul 2002 17:38:38 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Kernel ABI BoF at Linux-Kongress? [was: Header files and the kernel ABI]
Date: Thu, 1 Aug 2002 07:37:20 +1000
User-Agent: KMail/1.4.5
References: <aho5ql$9ja$1@cesium.transmeta.com>
In-Reply-To: <aho5ql$9ja$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200208010737.20093.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002 16:28, H. Peter Anvin wrote:
> OK... I have had a thought grinding in my head for a while, and wanted
> to throw it out for everyone to think about...
>
> In the libc4/libc5 days, we attempted to use kernel headers in user
> space.  This was a total mess, not the least because the kernel
> headers tended to pull in a lot of other kernel headers, and the
> datatypes were unsuitable to have spead all across userspace.
>
> In glibc, the official rule is "don't use kernel headers."  This
> causes problems, because certain aspects of the kernel ABI is only
> available through the include files, and reproducing them by hand is
> tedious and error-prone.
>
> I'm in the process of writing a very tiny libc for initramfs, and will
> likely have to deal with how to use the kernel ABI as well.
Well the initial enthusiasm appears to have passed, and nothing
is happening.

Is there interest in getting together to resolve this issue?

I note that the next major conference appears to be
Linux Kongress (Koln/Cologne) in early September. Maybe
we can get some glibc / other-libraries people there, and
make some progress.

If there is some interest (post off-list if preferred), I'll contact the
organisers and try to get a BoF together for this.

I'll look at linux.conf.au as an additional opportunity when
time gets a bit closer.

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
