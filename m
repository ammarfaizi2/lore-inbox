Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbSJNRtl>; Mon, 14 Oct 2002 13:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262007AbSJNRtl>; Mon, 14 Oct 2002 13:49:41 -0400
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:18103
	"EHLO mx1.rackable.com") by vger.kernel.org with ESMTP
	id <S262042AbSJNRsd>; Mon, 14 Oct 2002 13:48:33 -0400
Message-ID: <3DAB0647.9040603@rackable.com>
Date: Mon, 14 Oct 2002 11:00:39 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Theewara Vorakosit <g4465018@pirun.ku.ac.th>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS root on 2.4.18-14
References: <Pine.GSO.4.44.0210142012520.5993-100000@pirun.ku.ac.th>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2002 17:54:26.0198 (UTC) FILETIME=[BC622B60:01C273AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theewara Vorakosit wrote:

>Dear All,
>    I use Red Hat 8.0 and kernel 2.4.18-14, which come from redhat
>distribution. I want create a NFS-root kernel to build a diskless linux
>using NFS root. I select "IP kernel level configuration-> BOOTP, DHCP",
>NFS root support. I boot client using my kernel, it does not requrest for
>an IP address. It try to mount NFS root immediately. Do I forget
>something?
>Thanks,
>Theewara
>
>  
>
You need to give the kernel instructions to use dhcp.   I've always 
found this works:

ip=::::::dhcp nfsroot=192.168.1.5:/vol0/nfs/root/10.01


