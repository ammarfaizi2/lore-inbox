Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTJPRUT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 13:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTJPRUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 13:20:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22950 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263071AbTJPRUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 13:20:16 -0400
Message-ID: <3F8ED342.3020000@pobox.com>
Date: Thu, 16 Oct 2003 13:20:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: P@draigBrady.com
CC: Andrea Arcangeli <andrea@suse.de>, Erik Mouw <erik@harddisk-recovery.com>,
       Josh Litherland <josh@temp123.org>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <3F8ECA3E.4030208@draigBrady.com>
In-Reply-To: <3F8ECA3E.4030208@draigBrady.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P@draigBrady.com wrote:
> I thought a bit about this also and thought
> that in general the overhead of instant block/file
> duplicate merging is not worth it. Periodic
> post processing with a merging tool is
> much more efficient IMHO. Of course this is
> now only possible at the file level, but this

The sha1 hash method used by plan9 works at the block level.  venti 
_automatically_ coalesces duplicate blocks, without extra effort, simply 
by design.

	Jeff



