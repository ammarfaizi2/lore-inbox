Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268212AbTCCAi4>; Sun, 2 Mar 2003 19:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268218AbTCCAi4>; Sun, 2 Mar 2003 19:38:56 -0500
Received: from yossman.net ([209.162.234.20]:17159 "EHLO yossman.net")
	by vger.kernel.org with ESMTP id <S268212AbTCCAiy>;
	Sun, 2 Mar 2003 19:38:54 -0500
Message-ID: <3E62A676.9050900@yossman.net>
Date: Sun, 02 Mar 2003 19:48:54 -0500
From: Brian Davids <dlister@yossman.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <freesoftwaredeveloper@web.de>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.20 ide-scsi
References: <3E625282.8010101@hanaden.com> <200303022038.53606.freesoftwaredeveloper@web.de> <3E6261C3.1020700@pobox.com> <200303022112.18566.freesoftwaredeveloper@web.de>
In-Reply-To: <200303022112.18566.freesoftwaredeveloper@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:

> Yes I thought this also until yesterday. :)
> GRUB is configured this way in my case:
> kernel (hd1,0)/linux root=/dev/md0 hdd=ide-scsi hdb=ide-scsi mce vga=779
> 
> But nevertheless it didn't work until I disabled
> CONFIG_BLK_DEV_IDECD
> 
> It's somewhat strange, but.. :)

For me, it seems to be hdx=scsi that does the trick, NOT hdx=ide-scsi


Brian Davids

