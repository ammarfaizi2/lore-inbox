Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbULFM4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbULFM4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 07:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbULFM4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 07:56:49 -0500
Received: from ns1.enidan.ch ([217.8.216.11]:8925 "EHLO mail.local.net")
	by vger.kernel.org with ESMTP id S261513AbULFM4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 07:56:47 -0500
From: "Per Jessen" <per@computer.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 06 Dec 2004 13:28:54 +0100
X-Mailer: PMMail 2000 Professional (2.20.2711) For Windows 2000 (5.0.2195;4)
In-Reply-To: <20041206122003.3DFBE7D48D@mail.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: Fwd: 2.4.28 - kswapd excessive cpu usage under heavy IO
Message-Id: <20041206122938.D1E078E62F@mail.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2004 13:20:03 +0100, Per Jessen wrote:

> (apologies if this is sent more than once)
> I've found similar incidences in the archives, but none that indicates that a
> solution was found. 
> I'm seeing excessive cpu usage by kswapd on a 4way 500MHZ Xeon with 2GB RAM.  A
> find in a directory containing perhaps 6-700,000 files makes the box almost
> grind to a halt.  In 12days uptime, kswap has used 590:43.82, and during the
> find-exercise usually runs with 90-100% util.
> The file-system is 150GB with JFS117 on a software-RAID5 - not exactly optimal,
> I agree, but reasonably workable.

Correction - this is on 2.4.26, *not* 2.4.28. 

/Per

-- 
regards,
Per Jessen, Zurich
http://www.spamchek.com - let your spam stop here!


