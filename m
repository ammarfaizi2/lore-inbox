Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVBPPQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVBPPQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVBPPQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:16:45 -0500
Received: from ptb-relay01.plus.net ([212.159.14.212]:20753 "EHLO
	ptb-relay01.plus.net") by vger.kernel.org with ESMTP
	id S262030AbVBPPQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:16:44 -0500
Message-ID: <421363D4.5050209@dsvr.net>
Date: Wed, 16 Feb 2005 15:16:36 +0000
From: Jonathan Sambrook <jonathan@dsvr.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Klaus Muth <muth@hagos.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel panic with 2.4.26
References: <200501210715.03716.muth@hagos.de> <200502111015.54681.muth@hagos.de> <42132B31.7010503@dsvr.net> <200502161402.33666.muth@hagos.de>
In-Reply-To: <200502161402.33666.muth@hagos.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Muth wrote:
> Am Mittwoch, 16. Februar 2005 12:14 schrieb Jonathan Sambrook:

> Server oopsed again 10 minutes ago. Same symptoms. 

<sigh> schade


> The kernel upgrade did not 
> help... Would an update to an 2.6 kernel help or should I better turn 
> hyperthreading off?

My experience is running _modified_ 2.4 kernels. Turning HT off solved 
the problem here. Of course YMMV if the root cause is different.

I have no experience of running HT on 2.6. My hunch would be that more 
HT users run 2.6 than 2.4 nowadays, so the problem would've been raised 
by now? If so your choice depends on whether the joint benefits of HT 
and of 2.6 outweigh any effort of moving to 2.6.

Jonathan
