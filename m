Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWEUOfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWEUOfD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 10:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWEUOfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 10:35:03 -0400
Received: from lucidpixels.com ([66.45.37.187]:8917 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S964873AbWEUOfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 10:35:01 -0400
Date: Sun, 21 May 2006 10:35:00 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
cc: apiszcz@lucidpixels.com
Subject: Linux Kernel Source Compression
Message-ID: <Pine.LNX.4.64.0605211028100.4037@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was curious as to which utilities would offer the best compression ratio 
for the kernel source, I thought it'd be bzip2 or rar but lzma wins, 
roughly 6 MiB smaller than bzip2.

$ du -sk * | sort -n
33520   linux-2.6.16.17.tar.lzma
33760   linux-2.6.16.17.tar.rar
38064   linux-2.6.16.17.tar.rz
39472   linux-2.6.16.17.tar.szip
39520   linux-2.6.16.17.tar.bz
39936   linux-2.6.16.17.tar.bz2
40000   linux-2.6.16.17.tar.bicom
40656   linux-2.6.16.17.tar.sit
47664   linux-2.6.16.17.tar.lha
49968   linux-2.6.16.17.tar.dzip
50000   linux-2.6.16.17.tar.gz
51344   linux-2.6.16.17.tar.arj
57552   linux-2.6.16.17.tar.lzo
57984   linux-2.6.16.17.tar.F
81136   linux-2.6.16.17.tar.Z
94544   linux-2.6.16.17.tar.zoo
101216  linux-2.6.16.17.tar.arc
228608  linux-2.6.16.17.tar

$ du -sh * | sort -n
  33M    linux-2.6.16.17.tar.lzma
  33M    linux-2.6.16.17.tar.rar
  37M    linux-2.6.16.17.tar.rz
  39M    linux-2.6.16.17.tar.bicom
  39M    linux-2.6.16.17.tar.bz
  39M    linux-2.6.16.17.tar.bz2
  39M    linux-2.6.16.17.tar.szip
  40M    linux-2.6.16.17.tar.sit
  47M    linux-2.6.16.17.tar.lha
  49M    linux-2.6.16.17.tar.dzip
  49M    linux-2.6.16.17.tar.gz
  50M    linux-2.6.16.17.tar.arj
  56M    linux-2.6.16.17.tar.lzo
  57M    linux-2.6.16.17.tar.F
  79M    linux-2.6.16.17.tar.Z
  92M    linux-2.6.16.17.tar.zoo
  99M    linux-2.6.16.17.tar.arc
223M    linux-2.6.16.17.tar

