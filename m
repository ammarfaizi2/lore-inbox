Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbTJQTVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbTJQTVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:21:21 -0400
Received: from zeke.inet.com ([199.171.211.198]:47592 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S263577AbTJQTVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:21:20 -0400
Message-ID: <3F900115.5090009@inet.com>
Date: Fri, 17 Oct 2003 09:47:49 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>
CC: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016232020.GC29279@pegasys.ws>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
[snip]
> Now detecting files that are duplicates and linking them in
> some way might be a useful in a low-priority daemon.  But
> the links created would have to be sure to preserve them as
> seperate inodes so that overwrites break the loose link but
> not the user-created hardlink.

This would be very useful even in other situations...  particularly the 
'cp -lR linux-2.4.22 linux-2.4.22-work' trick.  Not having to worry 
about modifying the original version would be nice.  (Note that chmod -w 
can help with this, but it isn't automatic.)

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

