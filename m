Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTHZPpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbTHZPpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:45:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10426 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261151AbTHZPpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:45:41 -0400
Date: Tue, 26 Aug 2003 17:45:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Samphan Raruenrom <samphan@nectec.or.th>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Rdi1] Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
Message-ID: <20030826154514.GA30357@suse.de>
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org> <3F4B0343.7050605@nectec.or.th> <20030826083249.B20776@infradead.org> <3F4B23E2.8040401@nectec.or.th> <20030826105613.A23356@infradead.org> <20030826095830.GA20693@suse.de> <3F4B44C2.4030406@nectec.or.th> <20030826145821.A26398@infradead.org> <3F4B7D7B.50401@nectec.or.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4B7D7B.50401@nectec.or.th>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26 2003, Samphan Raruenrom wrote:
> GNOME automounter that use the new "event status notification" and also
> let users eject their CDs -
> "without polling" - possible?
> It must be real cool to write such daemon (polling make any hacker feel 
> guilty).

I don't want to burst your bubble, but you still have to poll when using
event status notification. You didn't note that the name of my program
was cd_poll.c? ;-)

But the poll is much quicker and more reliable.

-- 
Jens Axboe

