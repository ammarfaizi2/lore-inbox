Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbRLYApe>; Mon, 24 Dec 2001 19:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284174AbRLYApZ>; Mon, 24 Dec 2001 19:45:25 -0500
Received: from mail.gmx.de ([213.165.64.20]:55957 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S284160AbRLYApI>;
	Mon, 24 Dec 2001 19:45:08 -0500
Date: Tue, 25 Dec 2001 01:44:59 +0100
From: Christian Ohm <chr.ohm@gmx.net>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
Message-ID: <20011225004459.GB3752@moongate.thevoid.net>
In-Reply-To: <20011222220223.GA537@moongate.thevoid.net> <3C26F2AC.1050809@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C26F2AC.1050809@namesys.com>
User-Agent: Mutt/1.3.24i
Organization: theVoid
X-Operating-System: Linux moongate 2.4.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ReiserFS does not have a problem with large hard drives.  If you crash 
> while writing a file, you can damage it.  Not sure if that is your 
> problem, but maybe.

no just using it normally, copying files from the old to the new drive,
running apt-get dist-upgrade etc., and then, some files contain garbage.
only on reiserfs partitions (i copied about 3gb reiserfs to reiserfs and
about 15gb fat32 to fat32, both under linux), and seemingly random... as i
said, the file system looks good (right filesize etc.), the files just
contain garbage. so i think the contents of the files gets corrupted, and
not the file system entries for them. as for the reason why, i have no idea
(obviously).

bye & merry christmas
christian ohm
