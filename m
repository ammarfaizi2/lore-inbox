Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277341AbRJ3SXB>; Tue, 30 Oct 2001 13:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277363AbRJ3SWv>; Tue, 30 Oct 2001 13:22:51 -0500
Received: from mxfw.q-free.com ([62.92.116.8]:53255 "HELO mxfw")
	by vger.kernel.org with SMTP id <S277341AbRJ3SWi>;
	Tue, 30 Oct 2001 13:22:38 -0500
Message-ID: <3BDEEE81.8FE31930@q-free.com>
Date: Tue, 30 Oct 2001 19:16:33 +0100
From: Audun Jan Myrhol <audun@q-free.com>
Organization: q-free.com
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Padraig Brady <padraig@antefacto.com>
CC: linux-kernel@vger.kernel.org, ras2@tant.com
Subject: Re: Problem with SanDisk Compact Flash disks on IDE with kernel 2.4.x
In-Reply-To: <3BDED5D5.7C985134@q-free.com> <3BDEDC50.3070605@antefacto.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you,

 
> In summary you need the following kernel parameter:
> hdb=flash (I know your hdb is NOT flash but this is
> consistent with this "feature").

Perfect, it works, in some weeks my hair will be back!

>  BTW testing with 2.2.18, hdb would silently be ignored.
> Kernel panic is well probably more consistent with this
> "feature".

I forgot to write about the problems when trying to install Redhat 7.1
and Redhat 7.2 with the CF present, then the real IDE disk/dev/hdb was
never found.
Passing the parameter  (hdb=flash) to the distribution kernel at
install solved this too.

> Any progress/more info on why this "feature" is required?
> 
> Padraig.
> 

Audun
