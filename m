Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWHIPwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWHIPwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWHIPwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:52:36 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:35200 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751021AbWHIPwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:52:35 -0400
Message-ID: <44DA04C1.7040306@slaphack.com>
Date: Wed, 09 Aug 2006 11:52:33 -0400
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Pavel Machek <pavel@ucw.cz>, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Bernd Schubert <bernd-schubert@gmx.de>, reiserfs-list@namesys.com,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Clay Barnes <clay.barnes@gmail.com>,
       Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, ipso@snappymail.ca,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <44CF87E6.1050004@slaphack.com> <20060806225912.GC4205@ucw.cz> <44D99ED9.1030003@namesys.com>
In-Reply-To: <44D99ED9.1030003@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Pavel Machek wrote:
> 
>>
>> Yes, I'm afraid redundancy/checksums kill write speed,
>>
> they kill write speed to cache, but not to disk....  our compression
> plugin is faster than the uncompressed plugin.....

Regarding cache, do we do any sort of consistency checking for RAM, or 
do we leave that to some of the stranger kernel patches -- or just an 
occasional memtest?
