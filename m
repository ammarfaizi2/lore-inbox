Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264148AbUDGTMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUDGTMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:12:24 -0400
Received: from news.cistron.nl ([62.216.30.38]:13291 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S264148AbUDGTMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:12:22 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: dd PATCH: add conv=direct
Date: Wed, 7 Apr 2004 19:12:21 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c51jql$7j4$2@news.cistron.nl>
References: <20040406220358.GE4828@hexapodia.org> <20040406173326.0fbb9d7a.akpm@osdl.org> <20040407173116.GB2814@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1081365141 7780 62.216.29.200 (7 Apr 2004 19:12:21 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040407173116.GB2814@hexapodia.org>,
Andy Isaacson  <adi@hexapodia.org> wrote:
>The next feature to add would be OpenBSD-style "KB/s" reporting.  I'm
>not going there.
>
>diff -ur coreutils-5.0.91/doc/coreutils.texi
>coreutils-5.0.91-adi/doc/coreutils.texi

Doesn't it already do that ?

$ dd if=/dev/zero of=/tmp/file bs=4K count=100
100+0 records in
100+0 records out
409600 bytes transferred in 0.005108 seconds (80189583 bytes/sec)

$ dpkg -S /bin/dd
coreutils: /bin/dd
$ dpkg -s coreutils
Package: coreutils
Version: 5.0.91-2

Mike.

