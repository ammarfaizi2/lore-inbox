Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTJYScZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 14:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbTJYScZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 14:32:25 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:62224 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262761AbTJYScV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 14:32:21 -0400
To: Vid Strpic <vms@bofhlet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: *FAT problem in 2.6.0-test8
References: <20031024103225.GC1046@home.bofhlet.net>
	<20031024185953.GA9265@win.tue.nl>
	<87ismdoc2s.fsf@devron.myhome.or.jp>
	<20031025105559.GD1143@home.bofhlet.net>
	<87wuatmfnk.fsf@devron.myhome.or.jp>
	<20031025174102.GE1143@home.bofhlet.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 26 Oct 2003 03:32:13 +0900
In-Reply-To: <20031025174102.GE1143@home.bofhlet.net>
Message-ID: <87wuatkw2a.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vid Strpic <vms@bofhlet.net> writes:

> > > Maybe I should try to reformat the card in the reader?  My camera has
> > > 'delete all images' but no 'format card' I'm sorry...
> > Um.. Could you please test to reformat? Of course, do it after backup
> > the your disk image.
> 
> Backups were done yesterday, I'm on the backup-freak side ;)
> 
> Just reformatted, it works - used mkdosfs -F 12 -v /dev/sda1, camera
> reads the card and can write picture on it...
> 
> Reformatted card now can be mounted by standard fat.ko ...

Ok. Your camera isn't buggy, but your SmartMedia's card had the bad
format. (Unfortunately, it sounds like reason is unknown... Some
SmartMedia may have this bad format.)

Thanks for testing it. 
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
