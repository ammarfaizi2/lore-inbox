Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVL1QL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVL1QL0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 11:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVL1QL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 11:11:26 -0500
Received: from mx.laposte.net ([81.255.54.11]:11445 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S964852AbVL1QLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 11:11:25 -0500
Message-ID: <43B2B913.9090002@laPoste.net>
Date: Wed, 28 Dec 2005 17:10:59 +0100
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Mark Knecht <markknecht@gmail.com>
CC: Lee Revell <rlrevell@joe-job.com>, markus.kossmann@inka.de,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>, Michael Krufky <mkrufky@m1k.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. the latest and greatest ivtv is 0.5.x svn trunk
2. a week ago it still depended on some v4l cvs changes not merged
upstream (ie could not build without a private v4l tree dump)
3. and it had firmware loading problems with the latest 2.6.15-rc git
dumps
4. the merging process stalled considerably when the paken fork was
discovered

The root of the problem of course is ivtv developpers still haven't
understood the "release early, release often" part and are aiming for
a perfect (cleaned-up and feature-complete) driver before submitting
it. Instead of merging everything now (experimental) and finishing the
paken merge cleanup / inside the kernel.

ivtv 0.5 is not even available as a kernel patchset, so you get the
idea. ivtv writers would get a boatload of feedback if it behaved like
any other kernel patchset.

Now don't get me wrong, the ivtv people did and are doing a wonderful
job driver-side, but they seriously need to learn to integrate in the
kernel ecosystem. Someone wrote in the thread about the need to "kick"
them a bit to make them understand this. I'm afraid this feeling is
shared by a lot of other people. The low priority given to merging is
real frustrating.

Regards,

-- 
Nicolas Mailhot
