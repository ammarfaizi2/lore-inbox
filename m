Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290705AbSAROdQ>; Fri, 18 Jan 2002 09:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290706AbSAROdH>; Fri, 18 Jan 2002 09:33:07 -0500
Received: from genesis.westend.com ([212.117.67.2]:17070 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP
	id <S290705AbSAROcs>; Fri, 18 Jan 2002 09:32:48 -0500
Date: Fri, 18 Jan 2002 15:32:14 +0100
From: Christian Hammers <ch@westend.com>
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: ext3 fs corruption with 2.4.17
Message-ID: <20020118143214.GH28471@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Again problems with my filesystems (probably a mainboard/cpu problem). 
It is (^H^H^H was) a quite new ext3 fs that was created with 2.4.17 and the
very latest (stable) e2fsprogs and journalling. The device 8,7 was /var so 
the most used partition for write activity, read activity was mainly under
/usr/local).  

The filesystem was still usable but every write attempt lead to absolutely
nonsense entries so I unmounted and fsck'ed it with quite good success.

Does anybody knows what exactly this means and if it could be helpful to
track down the origin of the problems? Or did anybody else experienced this
messages before?

On Thu, Jan 17, 2002 at 07:05:03PM +0100, root wrote:
> Jan 17 19:01:15 HOSTNAME kernel: EXT3-fs error (device sd(8,7)): ext3_new_block: Allocating block in system zone - block = 5931009
> Jan 17 19:01:16 HOSTNAME kernel: EXT3-fs error (device sd(8,7)): ext3_new_block: Allocating block in system zone - block = 5931018
> Jan 17 19:01:16 HOSTNAME kernel: EXT3-fs error (device sd(8,7)): ext3_new_block: Allocating block in system zone - block = 5931019
[repeats several hundert times with increasing block numbers]

bye,

-christian-

-- 
Christian Hammers    WESTEND GmbH - Aachen und Dueren     Tel 0241/701333-0
ch@westend.com     Internet & Security for Professionals    Fax 0241/911879
           WESTEND ist CISCO Systems Partner - Premium Certified

