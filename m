Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315424AbSE2OuY>; Wed, 29 May 2002 10:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315425AbSE2OuX>; Wed, 29 May 2002 10:50:23 -0400
Received: from rdu26-247-095.nc.rr.com ([66.26.247.95]:21889 "HELO chapus.net")
	by vger.kernel.org with SMTP id <S315424AbSE2OuW>;
	Wed, 29 May 2002 10:50:22 -0400
Date: Wed, 29 May 2002 10:49:14 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tcpdump with CONFIG_FILTER causes Oops on Sparc
Message-ID: <20020529144913.GA17275@chapus.net>
In-Reply-To: <20020528220727.GA12229@chapus.net> <20020528.233534.27508491.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: "Eloy A. Paris" <peloy@chapus.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Tue, May 28, 2002 at 11:35:34PM -0700, David S. Miller wrote:

> What compiler was used to build this sparc64 kernel?

Whoops! Sorry I missed this bit of information; I know it's important.

'dmesg | grep gcc' reports this:

Linux version 2.4.19-pre8 (elparis@elparis-lnx) (gcc version egcs-2.92.11 19980921 (gcc2 ss-980609 experimental)) #7 Tue May 28 17:16:45 EDT 2002

Now, I have good news: Marcelo released 2.4.19-pre9 a little bit after
I started to play with 2.4.19-pre8, so today I grabbed -pre9, built it,
booted it, and now I have no problems whatsoever. Same compiler:

Linux version 2.4.19-pre9 (elparis@elparis-lnx) (gcc version egcs-2.92.11 19980921 (gcc2 ss-980609 experimental)) #9 Wed May 29 09:36:59 EDT 2002

Does this ring a bell, maybe something you fixed? (I see lots of fixes
from you in the -pre9 changelog.)

Let me know if you want further information, and thanks for whatever
magic you put into 2.4.19-pre9.

Cheers,

Eloy.-
