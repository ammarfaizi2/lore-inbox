Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbTLZW7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 17:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTLZW7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 17:59:12 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:62225 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S264155AbTLZW7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 17:59:11 -0500
Message-ID: <3FECBD42.7000500@xs4all.nl>
Date: Fri, 26 Dec 2003 23:59:14 +0100
From: Sander Sweers <sandersweers@xs4all.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 sound output - wierd effects
References: <1080000.1072475704@[10.10.2.4]>
In-Reply-To: <1080000.1072475704@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Upgraded my home desktop to 2.6.0. 
> Somewhere between 2.5.63 and 2.6.0, sound got screwed up - I've confirmed
> this happens on mainline, as well as -mjb.
> 
> If I leave xmms playing (in random shuffle mode) every 2 minutes or so,
> I'll get some wierd effect for a few seconds, either static, or the track 
> will mysteriously speed up or slow down. Then all is back to normal for 
> another couple of minutes.
> 
> Anyone else seen this, or got any clues? Else I guess I'm stuck playing
> bisection search.
> 

Yes had this problem, i found that it was the oss emulation. When i
switched to the alsa plugin the effect was gone.


