Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWIDVCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWIDVCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 17:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWIDVCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 17:02:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36531 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751430AbWIDVCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 17:02:37 -0400
Date: Mon, 4 Sep 2006 14:02:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Victor Hugo <victor@vhugo.net>
Cc: linux-kernel@vger.kernel.org, Victor Castro <victorhugo83@yahoo.com>,
       Jon Masters <jcm@jonmasters.org>
Subject: Re: [PATCH][RFC] request_firmware examples and MODULE_FIRMWARE
Message-Id: <20060904140208.03880214.akpm@osdl.org>
In-Reply-To: <CB81ECDC-0B48-4BE4-B9C0-C1CDBEC0F739@vhugo.net>
References: <CB81ECDC-0B48-4BE4-B9C0-C1CDBEC0F739@vhugo.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sep 2006 19:55:53 -0700
Victor Hugo <victor@vhugo.net> wrote:

> Hi Everyone,
> 
> I'm trying to become the firmware loader maintainer  
> (request_firmware) and I felt the first thing I should do is update  
> the incomplete example driver under Documentaion/firmware_class/.   
> The example (firmware_sample_driver.c) doesn't work out of box and  
> needs tweaking just to get it to compile.  I've added two files which  
> use request_firmware and the asynchronous request_firmware_nowait.

Thanks.

> The next step would be to update the documentation to make hotplug/ 
> udev functionality a little more clear.  Hopefully I can get this in  
> the next couple of days.

Documentation updates are welcome.

> Also, I'd like to comment on Jon Masters push to include the  
> MODULE_FIRMWARE api addition.  I strongly believe that policy should  
> not be included in driver code, in this case it's in the form of a  
> filename.

You should have cc'ed him!  Some people are not subscribed, and few read
it all.

> The firmware loader currently needs a filename passed to it so it can  
> then pass the $FIRMWARE environment variable to the hotplug script.   
> This is ok if you provide a generic filename like "firmware.bin" and  
> then let the hotplug script worry about version numbers, i.e.  
> "firmware-x.y.z.bin"
> 
> MODULE_FIRMWARE should be used to provide the generic filenames and  
> which order the files should be loaded (request_firmware can be  
> called various times), but I think its bad to have to change the  
> driver everytime a new firmware version is released.

Yes, that does sound bad, but what would I know ;)

> That said, here's the patch...

application/octet-stream.  Please don't do that.  Inlined-in-the-body is
much preferred.  If you cannot do that (ie: your MUA is lame but you don't
want to switch) then, in extremis, text/plain attachments are tolerated.

