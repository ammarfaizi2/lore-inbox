Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUEQOBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUEQOBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUEQOBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:01:23 -0400
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.112.162.124]:26122
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id S261179AbUEQOBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:01:21 -0400
Message-ID: <40A8C58F.3030200@coplanar.net>
Date: Mon, 17 May 2004 10:00:47 -0400
From: Jeremy Jackson <jerj@coplanar.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Santiago Garcia Mantinan <manty@manty.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: cramfs as initrd still fails in 2.4.27-pre2 [PATCH]
References: <20040514132955.GA6190@man.manty.net>
In-Reply-To: <20040514132955.GA6190@man.manty.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Santiago Garcia Mantinan wrote:
> Hi!
> 
> I've been trying to use the cramfs to hold my initrd images and it works ok
> in 2.6.6, but when testing it in 2.4.26 or 2.4.27rc2 I get this problem:
> 
> RAMDISK: cramfs filesystem found at block 0
> RAMDISK: Loading 2128 blocks [1 disk] into ram disk... done.
> Freeing initrd memory: 2128k freed
> cramfs: wrong magic

I just put ramdisk_blocksize=4096 on my kernel command line for 
kernel.org linux (debian's linux seems to work as is).

It would be nice if 2.4 didn't need that though.

-- 
Jeremy Jackson
Coplanar Networks
(519)897-1516
http://www.coplanar.net
