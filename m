Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWAWBJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWAWBJF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 20:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWAWBJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 20:09:04 -0500
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:41224 "EHLO
	smtp-vbr16.xs4all.nl") by vger.kernel.org with ESMTP
	id S932382AbWAWBJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 20:09:03 -0500
Message-ID: <43D42CA8.6060507@xs4all.nl>
Date: Mon, 23 Jan 2006 02:08:56 +0100
From: John Hendrikx <hjohn@xs4all.nl>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: NeilBrown <neilb@suse.de>
CC: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
References: <20060117174531.27739.patches@notabene>
In-Reply-To: <20060117174531.27739.patches@notabene>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown wrote:
> In line with the principle of "release early", following are 5 patches
> against md in 2.6.latest which implement reshaping of a raid5 array.
> By this I mean adding 1 or more drives to the array and then re-laying
> out all of the data.
>   
I think my question is already answered by this, but...

Would this also allow changing the size of each raid device?  Let's say 
I currently have 160 GB x 6, could I change that to 300 GB x 6 or am I 
only allowed to add more 160 GB devices?

