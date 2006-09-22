Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWIVQQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWIVQQo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWIVQQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:16:44 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:58551 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751081AbWIVQQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:16:43 -0400
Date: Fri, 22 Sep 2006 18:13:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
cc: "H. Peter Anvin" <hpa@zytor.com>, Dax Kelson <dax@gurulabs.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
In-Reply-To: <20060922140007.GK13639@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.61.0609221811560.12304@yvahk01.tjqt.qr>
References: <1158870777.24172.23.camel@mentorng.gurulabs.com>
 <20060921204250.GN13641@csclub.uwaterloo.ca> <45130792.9040104@zytor.com>
 <20060922140007.GK13639@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> widely used until there is an "lzip" which does the same thing.  I 
>> actually started the work of adding LZMA support to gzip, but then 
>> realized it would be better if a new encapsulation format with proper 
>> 64-bit support everywhere was created.
>
>It doesn't handle streaming?
>
>So you can't do: tar c dirname | 7zip dirname.tar.7z ?

man 7z [slightly changed for reasonability]:

  -si
      Read data from StdIn (eg: tar -c directory | 7z a -si directory.tar.7z)



Jan Engelhardt
-- 
