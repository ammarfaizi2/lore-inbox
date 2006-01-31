Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWAaCjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWAaCjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 21:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWAaCjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 21:39:53 -0500
Received: from terminus.zytor.com ([192.83.249.54]:12685 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030275AbWAaCjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 21:39:53 -0500
Message-ID: <43DECDB7.2070604@zytor.com>
Date: Mon, 30 Jan 2006 18:38:47 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Kyle Moffett <mrmacman_g4@mac.com>, klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: Exporting which partitions to md-configure
References: <43DEB4B8.5040607@zytor.com>	<17374.47368.715991.422607@cse.unsw.edu.au>	<859CB9D0-A1D3-4931-9D9F-96153D0F3E1B@mac.com> <17374.50453.727662.493504@cse.unsw.edu.au>
In-Reply-To: <17374.50453.727662.493504@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> Mac partition tables doesn't currently support autodetect (as far as I
> can tell).  Let's keep it that way.
> 

For now I guess I'll just take the code from init/do_mounts_md.c; we can 
worry about ripping the RAID_AUTORUN code out of the kernel later.

	-hpa

