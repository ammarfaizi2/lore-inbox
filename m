Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283864AbRLABO3>; Fri, 30 Nov 2001 20:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281307AbRLABOU>; Fri, 30 Nov 2001 20:14:20 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:15865
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281304AbRLABOK>; Fri, 30 Nov 2001 20:14:10 -0500
Date: Fri, 30 Nov 2001 17:14:03 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Tony Geerts <tgeerts@dyton.com>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [OOPS] 2.4.17-pre2
Message-ID: <20011130171403.M504@mikef-linux.matchmail.com>
Mail-Followup-To: Tony Geerts <tgeerts@dyton.com>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0111301849170.19977-100000@nitro.dyton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111301849170.19977-100000@nitro.dyton.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 06:52:15PM -0600, Tony Geerts wrote:
> The version does not get changed to 2.4.17-pre2 in the patch.
> Kernel version sticks at 2.4.16.
> 
> On digest mode, CC is appreciated.
> 

Patch:
--- 2.4.16-vanilla/Makefile	Wed Nov 28 18:43:59 2001
+++ 2.4.17-pre2/Makefile	Fri Nov 30 17:11:20 2001
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
-SUBLEVEL = 16
-EXTRAVERSION =
+SUBLEVEL = 17
+EXTRAVERSION = -pre2
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
