Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbUL2KZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUL2KZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 05:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUL2KZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 05:25:37 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:20455 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261370AbUL2KZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 05:25:33 -0500
Date: Wed, 29 Dec 2004 11:25:32 +0100
From: bert hubert <ahu@ds9a.nl>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: local root exploit confirmed in 2.6.10: Linux 2.6 Kernel Capability LSM Module Local Privilege Elevation
Message-ID: <20041229102532.GB9926@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1104268915.20714.20.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104268915.20714.20.camel@krustophenia.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 04:21:55PM -0500, Lee Revell wrote:
> Frank Barknecht pointed this out on linux-audio-dev, it's a horrible
> bug, I confirmed it in 2.6.10, and have not seen it mentioned on the
> list.

Although this sucks, it should be pointed out that it only grants root to
users able to force the loading of a certain module, aka 'root'.

Modules have always been free to give root capabilities to all users. We
don't usually ship these though :-)

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
