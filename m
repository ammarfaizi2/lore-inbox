Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318007AbSIOKpf>; Sun, 15 Sep 2002 06:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSIOKpf>; Sun, 15 Sep 2002 06:45:35 -0400
Received: from mout1.freenet.de ([194.97.50.132]:36770 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S318007AbSIOKpf>;
	Sun, 15 Sep 2002 06:45:35 -0400
Date: Sun, 15 Sep 2002 12:50:21 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.34-mm4
Message-ID: <20020915105021.GA444@prester.freenet.de>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
References: <3D82B5C3.229C6B1A@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D82B5C3.229C6B1A@digeo.com>
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

On Fri, 13 Sep 2002, Andrew Morton wrote:

> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.34/2.5.34-mm4/

With changing from 2.5.34-mm2 to -mm4 I have experienced some moments of
quite unresponsive behaviour. For example I am building X which at that
special moment causes pretty heavy disk load and the system doesn't respond
at all. I was using X and was not able to switch consoles or move mouse only
extremely sluggish.
I have seen that it used more swap that usual.

             total       used       free     shared    buffers     cached
Mem:        191096     159340      31756          0      10568      94100
-/+ buffers/cache:      54672     136424
Swap:       289160          0     289160

This is how it looks like under normal circumstances and when building X I
had 20M in swap usage which seemed quite a lot to me. Maybe I'm just wrong.
Unfortunately I was not able to start vmstat, first because I can't start
vmstat when system is not responding and second it doesn't work anyway
because of your changes.


Best regards,
Axel
