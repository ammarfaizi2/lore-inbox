Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTJaSPI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 13:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbTJaSPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 13:15:08 -0500
Received: from gaia.cela.pl ([213.134.162.11]:47109 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263468AbTJaSPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 13:15:06 -0500
Date: Fri, 31 Oct 2003 19:13:40 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: initrd help -- umounts root after pivot_root
In-Reply-To: <1067604362.5526.15.camel@tweedy.ksc.nasa.gov>
Message-ID: <Pine.LNX.4.44.0310311913220.29910-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you remember to perform
echo 0x0100 > /proc/sys/kernel/real-root-dev
in the /linuxrc init script?

Cheers,
MaZe.

