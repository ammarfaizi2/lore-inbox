Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314686AbSDVTvT>; Mon, 22 Apr 2002 15:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314709AbSDVTvT>; Mon, 22 Apr 2002 15:51:19 -0400
Received: from fungus.teststation.com ([212.32.186.211]:51976 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S314686AbSDVTvO>; Mon, 22 Apr 2002 15:51:14 -0400
Date: Mon, 22 Apr 2002 21:50:36 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 64bit archs doing incorrect magic for smbfs?
In-Reply-To: <3187FEB377F@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0204222136470.9063-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002, Petr Vandrovec wrote:

> If you have recent (2.2.0.18/2.2.0.19) ncpfs, format v4 is used (it allows
> for 32bit uid/gid). I have no non-ia32 test environment, so if anybody finds 
> that ncpfs does not work on any platform, feel free to send patches either 
> to me or to arch maintainers...

Unless the v3 and v4 structs have the same layout (and they don't,
although I may have developed a sudden cross-eydness [1]), the code can't
possibly work for all ncpmounts. It may be unused on some arch's because
they don't need 32->64 translation.

I suggest you put it on your list but below the ascii-fication, since that
is another (better?) solution to the same problem.

/Urban

[1]   http://www.anri.barc.usda.gov/emusnow/stereo/stereo.htm

