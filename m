Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267165AbSLDXxZ>; Wed, 4 Dec 2002 18:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbSLDXxY>; Wed, 4 Dec 2002 18:53:24 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:37148
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S267165AbSLDXxY>; Wed, 4 Dec 2002 18:53:24 -0500
Message-ID: <3DEE95D0.9010706@rackable.com>
Date: Wed, 04 Dec 2002 15:54:56 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Orion Poplawski <orion@cora.nwra.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS - IRIX client issues
References: <3DEE85D3.6070009@cora.nwra.com> <3DEE8EC2.2040305@rackable.com> <3DEE9425.40204@cora.nwra.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2002 23:59:06.0981 (UTC) FILETIME=[2169F150:01C29BF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Orion Poplawski wrote:

>>
> The mount comes up fine and works for quite a while and then crashes. 
> This is under relatively heavy load (tar files being unpacked, data 
> files manipulated, etc.).  No iptables/chains.
>
> The mount is automounted,  the resulting mtab entry on IRIX is:


  Are you using amd or autofs?  Does it occur when you manually mount 
the share? "mount lego:/export/turb3 /data/turb3"

>
> lego:/export/turb3 /data/turb3 nfs vers=3,rw,dev=100007 0 0
>
> I believe the mount is UDP,  I'm not specifying any special options.
>
> I'll look into trying nolock and v2.  SHould I try TCP?


  You could, but I was wondering if you could be hitting a TCP bug.


