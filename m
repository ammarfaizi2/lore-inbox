Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272329AbTHKGb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 02:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272368AbTHKGb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 02:31:57 -0400
Received: from pan.togami.com ([66.139.75.105]:26823 "EHLO pan.mplug.org")
	by vger.kernel.org with ESMTP id S272329AbTHKGbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 02:31:55 -0400
Subject: Re: 2.6-test3 compusa USB optical mouse
From: Warren Togami <warren@togami.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20030810215205.1028d3de.akpm@osdl.org>
References: <1060565776.2888.3.camel@laptop>
	 <20030810215205.1028d3de.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1060583512.2888.21.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Sun, 10 Aug 2003 20:31:53 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-10 at 18:52, Andrew Morton wrote:
> Warren Togami <warren@togami.com> wrote:
> >
> > I normally use Logitech optical USB mice in Linux.  I bought a "CompUSA
> > Optical USB Notebook Mouse" for $14 and the following happens in dmesg
> > in kernel-2.6.0-test3.
> > 
> > Known bug?  Should I Bugzilla this?
> > 
> > hub 1-1:0: debounce: port 2: delay 100ms stable 4 status 0x301
> > hub 1-1:0: new USB device on port 2, assigned address 8
> > drivers/usb/core/message.c: selecting invalid configuration 0
> > usb 1-1.2: failed to set device 8 default configuration (error=-22)
> > hub 1-1:0: new USB device on port 2, assigned address 9
> > drivers/usb/core/message.c: selecting invalid configuration 0
> > usb 1-1.2: failed to set device 9 default configuration (error=-22)
> 
> You don't state whether the mouse actually works.
> 
> Assuming it doesn't, yes, please bugzilla it, or bug the folks at
> linux-usb-devel@lists.sourceforge.net

http://bugzilla.kernel.org/show_bug.cgi?id=1077
Filed Bugzilla.  Indeed the mouse does not work.

Thanks,
Warren Togami
warren@togami.com

