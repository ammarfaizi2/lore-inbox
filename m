Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277568AbRKVMLU>; Thu, 22 Nov 2001 07:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277653AbRKVMLK>; Thu, 22 Nov 2001 07:11:10 -0500
Received: from fungus.teststation.com ([212.32.186.211]:42764 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S277568AbRKVMLB>; Thu, 22 Nov 2001 07:11:01 -0500
Date: Thu, 22 Nov 2001 13:10:53 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Petr =?ISO-8859-1?Q?Tite=28ra?= <P.Titera@century.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Filesize limit on SMBFS
In-Reply-To: <3BFCC0EF.5050308@century.cz>
Message-ID: <Pine.LNX.4.30.0111221305520.4258-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Petr Tite(ra wrote:

>     is maximum file size on SMBFS really 2GB? I cannot create file 
> bigger than that.

Yes.

I have patches if you want to be my victim^Wtester.

You must be using an NT/2k/XP machine as server, win9x has a 4G limit
(vfat limit?).

Let me know which 2.4 kernel you are using. And if you don't already run a
kernel you compiled yourself, please do that first as you must recompile
to test the patches anyway (smbfs as a module is recommended, then you
should be able to only rebuild the modules part).

/Urban

