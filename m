Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbULUIkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbULUIkE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 03:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbULUIkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 03:40:04 -0500
Received: from mout.alturo.net ([212.227.15.20]:35059 "EHLO mout.alturo.net")
	by vger.kernel.org with ESMTP id S261199AbULUIkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 03:40:00 -0500
Message-ID: <41C7E0D4.6010207@informatik.uni-bremen.de>
Date: Tue, 21 Dec 2004 09:37:40 +0100
From: Arne Caspari <arnem@informatik.uni-bremen.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: girish wadhwani <girish.wadh@gmail.com>
CC: Lee Revell <rlrevell@joe-job.com>, Adrian Bunk <bunk@stusta.de>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
References: <20041220015320.GO21288@stusta.de>	 <41C694E0.8010609@informatik.uni-bremen.de>	 <20041220175156.GW21288@stusta.de>	 <1103576759.1252.93.camel@krustophenia.net> <e2e1047f04122013493f5b0151@mail.gmail.com>
In-Reply-To: <e2e1047f04122013493f5b0151@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

girish wadhwani wrote:
> 
> I don't think the symbols are an issue for the Freebob project.
> Atleast, not right now. The code doesn't use the symbols. Most of the
> driver is intended to be in userspace anyways.
> Moreover, if you are going to break in the interface, you might as
> well do it before the driver
> is written rather than after.

I also would like to write an ALSA audio driver for the Apple iSight and 
I can assure you: Removal of the exports will make this impossible to.

  /Arne
