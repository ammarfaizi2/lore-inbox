Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVHaO3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVHaO3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 10:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVHaO3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 10:29:09 -0400
Received: from newton.linux4geeks.de ([193.30.1.1]:20874 "EHLO
	newton.linux4geeks.de") by vger.kernel.org with ESMTP
	id S964819AbVHaO3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 10:29:08 -0400
Date: Wed, 31 Aug 2005 16:28:59 +0200 (CEST)
From: Sven Ladegast <sven@linux4geeks.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
In-Reply-To: <1125495297.3355.24.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0508311623540.2012@cassini.linux4geeks.de>
References: <20050830030959.GC8515@g5.random> 
 <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> 
 <1125412611.8276.9.camel@localhost.localdomain> 
 <Pine.LNX.4.63.0508310033400.1930@cassini.linux4geeks.de> 
 <1125444317.13646.6.camel@localhost.localdomain> 
 <Pine.LNX.4.63.0508310117230.1930@cassini.linux4geeks.de>
 <1125495297.3355.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005, Alan Cox wrote:

>> Registering means to create an ID for the system? Something out of
>> timestamp plus your PCI IDs and CPU info and so on?
>
> Or have the other end issue you some kind of secure cookie, which was my
> thought. Generating it locally as you suggest would be even better as a
> hardware change would make a box change identity automatically

Reading twice is sometimes better. :) It must have been late yesterday...

Well changing ID automagically can be okay because a system changes its ID 
from time to time and so you cannot track a certain system/person easily.

Why not generating a unique system ID at compilation stage of the kernel 
if the apopriate kernel option is enabled? This needn't have something to 
do with klive...just a unique kernel-ID or something like that.

klive, if userspace or not, finally makes use of this ID to generate live 
stats of kernel usage. PCI-IDs, CPU and whatever else could be used as a 
salt to generate a really UNIQE ID...

Sven
