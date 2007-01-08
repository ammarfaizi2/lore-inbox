Return-Path: <linux-kernel-owner+w=401wt.eu-S1030481AbXAHDwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbXAHDwk (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 22:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbXAHDwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 22:52:40 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:3573 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030479AbXAHDwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 22:52:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ENi8oemlZ45ducFi5OvidV2Q8JU50pDiAl3efYVWhLk/T4lwmz8c8d6E0rqCbb8Ev+hL8u3Wos9LQq7wClIY9ZwXzEz8AEJwLxUtYU5t8mMpYWHff3gPErDWhIoiqjjl6oDDqrO2UKRx4R6C5JwUqSicGgBoNkBYh/OdiotiNqQ=
Message-ID: <45A1C000.7080500@gmail.com>
Date: Mon, 08 Jan 2007 12:52:32 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: philippe.grenard@m4x.org
CC: Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: (Another?) Seagate / Sil3112a problem...
References: <J5J0S1$E84BD2336C01F896088E954AAF120859@laposte.net> <20061109135956.b744a3a7.akpm@osdl.org> <200701071704.36288.philippe.grenard@m4x.org>
In-Reply-To: <200701071704.36288.philippe.grenard@m4x.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[cc'ing lkml and linux-ide]

Philippe Grenard wrote:
> To "close" this problem, here are the latest news :
> I just bought some new power supply, and the problem has gone...
> Maybe that was due to poor power flow or crappy connexion ?...
> 
> now everything seems to work well, so as suspected, it was probably hardware 
> problem.
> 
> Sorry for that "false alarm", thanks again for everything, and keep up the 
> good work!

Ah... so it was another one of those PSU problems.  This problem is
becoming more prevalent these days.  Dual 12v lane PSUs suck for driving
a lot of disks.  They don't seem to allocate enough power to molex/sata
connectors.

-- 
tejun
