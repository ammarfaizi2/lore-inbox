Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTIJISu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbTIJISu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:18:50 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:14013 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264929AbTIJISt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:18:49 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16222.56935.210391.452489@laputa.namesys.com>
Date: Wed, 10 Sep 2003 12:18:47 +0400
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Bernd Schubert <bernd-schubert@web.de>, linux-kernel@vger.kernel.org
Subject: Re: inode generation numbers
In-Reply-To: <20030909140751.E18851@schatzie.adilger.int>
References: <200309092108.37805.bernd-schubert@web.de>
	<20030909140751.E18851@schatzie.adilger.int>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
 > On Sep 09, 2003  21:08 +0200, Bernd Schubert wrote:
 > > for a user space nfs-daemon it would be helpful to get the inode generation 
 > > numbers. However it seems the fstat() from the glibc doesn't support this, 
 > > but refering to some google search fstat() from some (not all) other unixes 
 > > does.
 > > Does anyone know how to read those numbers from userspace with linux?
 > 
 > For ext2/ext3 filesystems you can use EXT2_GET_VERSION ioctl for this.
 > Maybe reiserfs as well.

yes.

 > 
 > Cheers, Andreas

Nikita.

