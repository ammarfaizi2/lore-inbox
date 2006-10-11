Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWJKOHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWJKOHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWJKOHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:07:46 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:53768 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1030393AbWJKOHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:07:45 -0400
Date: Wed, 11 Oct 2006 16:07:45 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Frank Gevaerts <frank@gevaerts.be>, Robert Love <rlove@rlove.org>,
       linux-kernel@vger.kernel.org
Subject: Re: patch : hdaps on Thinkpad R52
Message-Id: <20061011160745.605fc944.khali@linux-fr.org>
In-Reply-To: <20060408170238.4e241eac.khali@linux-fr.org>
References: <20060314205758.GA9229@gevaerts.be>
	<20060328182933.4184db3f.khali@linux-fr.org>
	<20060328170045.GA10334@gevaerts.be>
	<20060401170422.cc2ff8c2.khali@linux-fr.org>
	<20060403163541.GA4571@gevaerts.be>
	<20060408170238.4e241eac.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Franck,

Quoting myself back in April:
> > I just had a mail from another R52 user, reporting that his system
> > (also 1846AQG) also reports ThinkPad H.
> 
> I gathered data on my side too, the three R52 I had reports for used
> "ThinkPad R52" but these had different machine type/model. I guess that
> the 1846AQG is somehow different, but probably you don't know why?
> 
> So I suppose we could add that "ThinkPad H" identifier string to the
> hdaps driver after all, as you proposed in the first place. I'm only
> worried that the "H" suffix is really short, and I hope that no other
> model not supported by the driver (or needing the invert option) will
> ever have the same identifier. Time will tell.

I am told that a newer BIOS of the Thinkpad R52 fixes the machine name
in the DMI table.
http://www.thinkwiki.org/wiki/List_of_DMI_IDs#R_series
Can you please confirm this by upgrading the BIOS of your machine and
removing the "ThinkPad H" entry from the hdaps driver?

Thanks,
-- 
Jean Delvare
