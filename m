Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWAJAeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWAJAeH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWAJAeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:34:07 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:58842 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932130AbWAJAeG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:34:06 -0500
Date: Mon, 9 Jan 2006 16:29:45 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: John Rigg <ad@sound-man.co.uk>
cc: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>,
       Hannu Savolainen <hannu@opensound.com>, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
In-Reply-To: <20060110001617.GA5154@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0601091628340.4005@qynat.qvtvafvgr.pbz>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de>
 <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de>
 <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
 <20060109232043.GA5013@localhost.localdomain> <Pine.LNX.4.62.0601091515570.4005@qynat.qvtvafvgr.pbz>
 <20060110001617.GA5154@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006, John Rigg wrote:

>> does the CPU touch the data for these, or do you DMA directly from
>> userspace (i.e. "zero-copy")?
>
> The cards I mentioned use DMA. RME actually advertises that some of their
> cards can handle 52 channels with zero CPU load. Their onboard DSPs can
> also do routing and mixing, again without touching the CPU.

I was under the (apparently mistaken) impression that you couldn't DMA 
from userspace (something to do with the possibility that the userspace 
memory pages could be swapped out in the middle of the DMA)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

