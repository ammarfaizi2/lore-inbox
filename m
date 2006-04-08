Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWDHPCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWDHPCn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 11:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWDHPCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 11:02:43 -0400
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:23050 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S964987AbWDHPCm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 11:02:42 -0400
Date: Sat, 8 Apr 2006 17:02:38 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Frank Gevaerts <frank@gevaerts.be>
Cc: Robert Love <rlove@rlove.org>, linux-kernel@vger.kernel.org
Subject: Re: patch : hdaps on Thinkpad R52
Message-Id: <20060408170238.4e241eac.khali@linux-fr.org>
In-Reply-To: <20060403163541.GA4571@gevaerts.be>
References: <20060314205758.GA9229@gevaerts.be>
	<20060328182933.4184db3f.khali@linux-fr.org>
	<20060328170045.GA10334@gevaerts.be>
	<20060401170422.cc2ff8c2.khali@linux-fr.org>
	<20060403163541.GA4571@gevaerts.be>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Franck,

Sorry for the late answer...

> > OK, so as strange as it sounds, that's really the string as stored in
> > the DMI table. How odd... You have to understand that I'm a bit
> > reluctant to adding it officially to the hdaps driver, given that it
> > clearly looks like a bogus table in your laptop. I guess that you only
> > have one laptop with this string?
> 
> I just had a mail from another R52 user, reporting that his system
> (also 1846AQG) also reports ThinkPad H.

I gathered data on my side too, the three R52 I had reports for used
"ThinkPad R52" but these had different machine type/model. I guess that
the 1846AQG is somehow different, but probably you don't know why?

So I suppose we could add that "ThinkPad H" identifier string to the
hdaps driver after all, as you proposed in the first place. I'm only
worried that the "H" suffix is really short, and I hope that no other
model not supported by the driver (or needing the invert option) will
ever have the same identifier. Time will tell.

Thanks,
-- 
Jean Delvare
