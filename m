Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267279AbUHDGeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267279AbUHDGeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267293AbUHDGeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:34:44 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:1763 "EHLO
	acheron.informatik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S267279AbUHDGem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:34:42 -0400
Message-ID: <41108380.6080809@bio.ifi.lmu.de>
Date: Wed, 04 Aug 2004 08:34:40 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
References: <410F481C.9090408@bio.ifi.lmu.de> <64bf.410f9d6f.62af@altium.nl> <ceouv0$7s8$2@news.cistron.nl>
In-Reply-To: <ceouv0$7s8$2@news.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:

> If having /dev mounted read-only means you cannot open devices
> like /dev/console read/write then that is a bug in the NFS client
> in the kernel.

Which matches the fact the it works with server running 2.6 and
client running 2.4.

> 
> On all other filesystems (ext2, ext3, xfs etc) there's no problem
> opening devices r/w on a read-only filesystem.

Should I report that as bug to someone special?

cu,
Frank


-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

