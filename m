Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269305AbUHZRpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269305AbUHZRpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269295AbUHZRoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:44:07 -0400
Received: from smtp.terra.es ([213.4.129.129]:3835 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id S269310AbUHZRkY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:40:24 -0400
Date: Thu, 26 Aug 2004 19:40:10 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Rik van Riel <riel@redhat.com>
Cc: jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040826194010.548e4a4c.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0408261315240.27909-100000@chimarrao.boston.redhat.com>
References: <20040826190548.3e67726f.diegocg@teleline.es>
	<Pine.LNX.4.44.0408261315240.27909-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 26 Aug 2004 13:16:22 -0400 (EDT) Rik van Riel <riel@redhat.com> escribió:

> So all I need to do is "cat /bin | gzip -9 > /path/to/backup.tar.gz" ?

/bin could be separated (like linus said) but cat /bin/.compound could do
it. This is the /etc/passwd Hans' example, I think:

"If /new_syntax_access_path/big_directory_of_small_files/.glued is a plugin that
aggregates every file in big_directory_of_small_files with a delimiter
separating every file within the aggregation, then one can simply type emacs
/new_syntax_access_path/big_directory_of_small_files/.glued, and the filesystem
has done all the work emacs needs to be effective at this. Not a line of emacs
needs to be changed."
