Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbUBPNte (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbUBPNtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:49:12 -0500
Received: from ns.schottelius.org ([213.146.113.242]:45207 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S265533AbUBPNqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:46:21 -0500
Date: Mon, 16 Feb 2004 14:46:28 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: smbfs / loop: problematic or not unuseable?
Message-ID: <20040216134628.GL1881@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

While still suffering from my more or less dead harddisk I am seeing
other nice problems. I copied my blowfish encrypted partition to a samba
server. Now I want to mount it and use it:

pc-it-nico# mount
[...]
//fs2/home on /home/nico/fs2 type smbfs (rw)

pc-it-nico# mount /home/nico/fs2/home-13-Feb-2004.tar.crypt /tmp/ -o loop,encryption=blowfish 
Password: 
ioctl: LOOP_SET_FD: Invalid argument

Well, let's try to use a local copy:

pc-it-nico# cd ~nico/fs2
pc-it-nico# cp home-13-Feb-2004.tar.crypt ..
pc-it-nico# cd ..
pc-it-nico# mount -t xfs  home-13-Feb-2004.tar.crypt scice -o loop,encryption=blowfish
pc-it-nico#

This works fine.

Just wanted to report this and ask whether this is what it should be.

Greetings,

Nico

ps: If somebody can recommened me a good manufacturer for 2.5" notebook
    disks, please send me a private mail. I am looking for something
    running longer than 2 months, having some performance, still beiing
    not too loud :)


