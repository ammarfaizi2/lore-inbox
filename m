Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbSKEQ4j>; Tue, 5 Nov 2002 11:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264916AbSKEQ4j>; Tue, 5 Nov 2002 11:56:39 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:27541 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264915AbSKEQ4j>; Tue, 5 Nov 2002 11:56:39 -0500
Subject: Re: Linux v2.5.46
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211050806151.2762-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211050806151.2762-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 17:25:02 +0000
Message-Id: <1036517102.4827.98.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 16:08, Linus Torvalds wrote:
> Especially since we expect the array to be potentially megabytes in the 
> end (especially if somebody wants to make a bootable CD using this), and 
> at least traditional gcc's would do horrible O(n^2) things with big 
> initialized arrays. 

Newer gcc is much saner, but there are other ways to do it - gas is
quite happy to chew a 10Mb .byte file 8)

