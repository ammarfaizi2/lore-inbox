Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVA0MxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVA0MxC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 07:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVA0MxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 07:53:02 -0500
Received: from village.ehouse.ru ([193.111.92.18]:3084 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262602AbVA0Mwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 07:52:51 -0500
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: Vladimir Saveliev <vs@namesys.com>
Subject: Re: [2.6.11-rc2] kernel BUG at fs/reiserfs/prints.c:362
Date: Thu, 27 Jan 2005 15:52:47 +0300
User-Agent: KMail/1.7.2
Cc: reiserfs-list@namesys.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       admin@list.net.ru
References: <200501271024.13778.rathamahata@ehouse.ru> <1106821035.3270.30.camel@tribesman>
In-Reply-To: <1106821035.3270.30.camel@tribesman>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501271552.48586.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 January 2005 13:17, Vladimir Saveliev wrote:
> Hello
> 
> On Thu, 2005-01-27 at 10:24, Sergey S. Kostyliov wrote:
> > Hello all,
> > 
> > Here is a BUG() I've just hited on quota enabled reiserfs disk.
> > 
> > rathamahata@dev rathamahata $ mount | grep /dev/sdb2
> > /dev/sdb2 on /var/www type reiserfs (rw,noatime,nodiratime,data=writeback,grpquota,usrquota)
> > rathamahata@dev rathamahata $
> > 
> > REISERFS: panic (device sdb2): journal_begin called without kernel lock held
> 
> Would you check whether this patch helps, please?
That fixes it. Thank you!

-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org
