Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269673AbRHIFYJ>; Thu, 9 Aug 2001 01:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269675AbRHIFX7>; Thu, 9 Aug 2001 01:23:59 -0400
Received: from sputnik.senv.net ([213.157.66.5]:20745 "HELO sputnik.senv.net")
	by vger.kernel.org with SMTP id <S269673AbRHIFXv>;
	Thu, 9 Aug 2001 01:23:51 -0400
Date: Thu, 9 Aug 2001 07:57:10 +0300 (EEST)
From: Jussi Hamalainen <count@theblah.org>
X-X-Sender: <count@mir.senv.net>
To: Kalpesh Shah <kalpesh@cs.utexas.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linuz 2.2.19
In-Reply-To: <Pine.LNX.4.33.0108081216320.29630-100000@viper.cs.utexas.edu>
Message-ID: <Pine.LNX.4.33.0108090752270.27416-100000@mir.senv.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2001, Kalpesh Shah wrote:

> how can you find the default maximum segement size (mss) in
> Linux 2.2.19?

AFAIK the MSS defaults to the MTU of the network interface the
packet will be sent to. You can change it for any given route like
this:

route add default gw foobar mss 1460

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.org ]=-

