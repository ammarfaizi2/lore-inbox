Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTEVGjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 02:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbTEVGjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 02:39:12 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:6080 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S262182AbTEVGjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 02:39:10 -0400
From: Artemio <artemio@artemio.net>
To: linux-kernel@vger.kernel.org
Subject: Re: HELP: kernel won't boot from /dev/sdb1
Date: Thu, 22 May 2003 09:47:38 +0300
User-Agent: KMail/1.5
References: <3ECC3D18.201@torque.net>
In-Reply-To: <3ECC3D18.201@torque.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305220927.26405.artemio@artemio.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 May 2003 05:59, Douglas Gilbert wrote:
> Those number are in hex, so "811" is major 8, minor 17 which
> is (or should be) /dev/sdb1. Look earlier in the boot up
> sequence, where the aic79xx driver is loaded and scans
> for devices. It should say that it has attached /dev/sdb .
> You may need a later version of that driver. Visit:
>      http://people.FreeBSD.org/~gibbs/linux
>
> Doug Gilbert

Thank you very much! 

I found the source tarball there - aic79xx-linux-2.4-20030520-tar.gz. 

(Also, what is aic79xx-linux-2.4-20030520.bksend.gz - seems to be some 
changelog?)

I will to build everything today (I have two AIC 7902 drives on that machine).


Many thanks again.

Artemio.




