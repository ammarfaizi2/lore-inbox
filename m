Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUCRCOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 21:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUCRCOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 21:14:10 -0500
Received: from mail.cyclades.com ([64.186.161.6]:59298 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262351AbUCRCOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 21:14:07 -0500
Date: Wed, 17 Mar 2004 23:03:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Mika Fischer <mika_fischer@gmx.net>
Cc: linux-kernel@vger.kernel.org, <viro@parcelfarce.linux.theplanet.co.uk>,
       <dwmw2@infradead.org>
Subject: Re: [BUG] 2.4.25: kernel BUG at inode.c:334!
In-Reply-To: <3545183.U0lkPHFrCm@msgid.zoopnet.de>
Message-ID: <Pine.LNX.4.44.0403172301420.1670-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Mar 2004, Mika Fischer wrote:

> Hi!
> 
> This happened on a heavily loaded dual P-III webserver using vanilla 2.4.25.
> Filesystems are all ext3 with quota enabled.
> 
> Output of ksymoops and .config are attached.
> 
> The BUG has up until now only occured once (that we know of) but we're
> having general stability problems with this machine (about a reboot a
> week).

Hum, ho. I'm not really how this fault could be happening.

David and Viro know more about this VFS internals. 

Anyway, do you have any output from the weekly crashes? 

> Any help with debugging this would be appreciated.
> 
> This is a production machine but in the near future it might become
> available for testing.
> 
> If additional information is needed I'd be happy to provide it.

