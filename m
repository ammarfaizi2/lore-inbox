Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUCIKp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 05:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbUCIKp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 05:45:57 -0500
Received: from brest.ifremer.fr ([134.246.155.1]:20160 "EHLO brest.ifremer.fr")
	by vger.kernel.org with ESMTP id S261857AbUCIKp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 05:45:56 -0500
Message-ID: <404DA061.8000806@infini.fr>
Date: Tue, 09 Mar 2004 11:45:53 +0100
From: Olivier ARCHER <olivier.archer@infini.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.2.1) Gecko/20030225
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bind Mount Extensions (RO --bind mounts)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I've tried
http://www.ussg.iu.edu/hypermail/linux/kernel/0309.3/0802.html
to try the 'Bind Mount Extensions (RO --bind mounts)'

I've applied the patch on 2.4.24 and 2.6.3, without effects, ie

mount -t ext2 -o ro /dev/hdc7 /mnt/ro
mount --bind -o rw /mnt/ro /mnt/ro2rw
touch  /mnt/ro2rw/test
touch: connot touch '/mnt/ro2rw/test': Read Only file system

have I miss something ?

curently, i'm running up-to date debian unstable with mount-2.12 and a 
patched version ( 
http://vserver.13thfloor.at/Experimental/patch-2.6.0-test3-bme0.03.diff) 
  of 2.6.3

BTW, is this patch could work on NFS RO mounts ? I'm very interressted 
in it because y try to mount / from nfs RO. I've got some success with 
http://translucency.sourceforge.net/, But I'd would like test others 
approach.

Thx

--
Olivier

