Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289997AbSAOQFw>; Tue, 15 Jan 2002 11:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289998AbSAOQFm>; Tue, 15 Jan 2002 11:05:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:1506 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289997AbSAOQF2>;
	Tue, 15 Jan 2002 11:05:28 -0500
Date: Tue, 15 Jan 2002 09:46:28 -0600 (CST)
From: Paul Larson <plars@austin.ibm.com>
X-X-Sender: <plars@eclipse.ltc.austin.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.2
In-Reply-To: <Pine.LNX.4.40.0201142042570.935-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201150943210.3557-100000@eclipse.ltc.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Davide Libenzi wrote:
> Linus, i've a weird behavior with 2.5.2
> swapon first fails at boot ( early stage ) then it succeed ( late boot
> stage ) but the swap is not actually activated. Running swapon by hand it
> reports a seccessful operation but the swap is not on.
> I'm trying to understand what is happening ...

I am having this problem also

# swapon /dev/hda2
swapon: /dev/hda2: Success
# free
             total       used       free     shared    buffers     cached
Mem:        254492      40236     214256          0       2220      22432
-/+ buffers/cache:      15584     238908
Swap:            0          0          0
#

-Paul Larson

