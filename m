Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422715AbVLONB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbVLONB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbVLONB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:01:58 -0500
Received: from smtpout9.uol.com.br ([200.221.4.200]:47331 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1422715AbVLONB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:01:58 -0500
Date: Thu, 15 Dec 2005 11:01:28 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix the EMBEDDED menu
Message-ID: <20051215130128.GA14024@ime.usp.br>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051214140531.7614152d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew et. al.

On Dec 14 2005, Andrew Morton wrote:
> It looks like that patch needs to be reverted or altered anyway.
> sparc64 machines are failing all over the place, possibly due to
> newly-exposed compiler bugs.

Just a (luser) datapoint here: since I have computers with small cache
(Celeron Mendocino and Duron Spitfire), I am always trying to save some
bytes here (being minimalistic as much as I can) and there and I have
been compiling kernels since about 2.6.10 with -Os in my Debian systems.

I'm currently using Debian's GCC 4.0.2 and everything seems fine here
with kernel 2.6.15-rc5.

Hope a data point helps towards making this option more visible.


Regards, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
