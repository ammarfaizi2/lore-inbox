Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbULMBKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbULMBKi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 20:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbULMBKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 20:10:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:30624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262181AbULMBKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 20:10:30 -0500
Message-ID: <41BCEB0A.3060807@osdl.org>
Date: Sun, 12 Dec 2004 17:06:18 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Danny Beaudoin <beaudoin_danny@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Description should be updated
References: <BAY21-F31C2845A332866774C3A2CF3AB0@phx.gbl>
In-Reply-To: <BAY21-F31C2845A332866774C3A2CF3AB0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny Beaudoin wrote:
> Hi again!
> In Device Drivers/Graphics Support/Console display driver support/VGA 
> test console (NEW)

drivers/video/console/Kconfig

> The description is the following:
> "
> Saying Y here will allow you to use Linux in text mode through a
> display that complies with the generic VGA standard. Virtually
> everyone wants that.
> 
> The program SVGATextMode can be used to utilize SVGA video cards to
> their full potential in text mode. Download it from
> <ftp://ibiblio.org/pub/Linux/utils/console/>.
> 
> Say Y.
> "
> This is not an option anymore and there is no choice to be made, 
> therefore the user doesn't have to/can't say Y. This should be only a 
> description.

It is an option if EMBEDDED is true or X86 is false.
For usual X86 it is forced to 'y'.
However, if you can suggest some better description,
that's OK too.

> Thanks for last time, I hadn't realized that there was a 
> misunderstanding on what I meant
> and "Are you sure?  It makes sense to me the way it currently is..." 
> made me think that you didn't see the use of having all 'x86' written 
> all the same, with a lowercase x. :-)
> 
> Well, good job guys, keep it up!


-- 
~Randy
