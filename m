Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbTF2VRp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 17:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbTF2VRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 17:17:45 -0400
Received: from smtp.terra.es ([213.4.129.129]:40278 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id S265027AbTF2VRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 17:17:43 -0400
Date: Sun, 29 Jun 2003 23:32:01 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: rmoser <mlmoser@comcast.net>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-Id: <20030629233201.5db9c248.diegocg@teleline.es>
In-Reply-To: <200306291545410600.02136814@smtp.comcast.net>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
	<20030629132807.GA25170@mail.jlokier.co.uk>
	<3EFEEF8F.7050607@post.pl>
	<20030629192847.GB26258@mail.jlokier.co.uk>
	<20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
	<200306291545410600.02136814@smtp.comcast.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jun 2003 15:45:41 -0400
rmoser <mlmoser@comcast.net> wrote:

> no, in-kernel conversion between everything.  You don't think it can be done?
> It's not that difficult a problem to manage data like that :D

personally, whan i want to change the filesystem of my data (not very often
though, 2 or 3 times in my life, and that was because i was bored), i just do
a new particion with the filesystem i want, mount it, and cp -a everything I
want (or tar it, or use whatever backup/script software you want). Thats the
way of doing things, IMHO. Appart that you can convert all your data to
another filesystem, it gives you flexibility, which I wouldn't get in the
kernel. 

And well...how many people are you expecting to change from one filesystem
to another in the real world?
