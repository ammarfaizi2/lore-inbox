Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWJKOi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWJKOi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWJKOi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:38:28 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:23754 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1030364AbWJKOi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:38:27 -0400
Date: Wed, 11 Oct 2006 16:38:16 +0200
From: Frank Gevaerts <frank@gevaerts.be>
To: Jean Delvare <khali@linux-fr.org>
Cc: Frank Gevaerts <frank@gevaerts.be>, Robert Love <rlove@rlove.org>,
       linux-kernel@vger.kernel.org
Subject: Re: patch : hdaps on Thinkpad R52
Message-ID: <20061011143816.GA5753@gevaerts.be>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	Frank Gevaerts <frank@gevaerts.be>, Robert Love <rlove@rlove.org>,
	linux-kernel@vger.kernel.org
References: <20060314205758.GA9229@gevaerts.be> <20060328182933.4184db3f.khali@linux-fr.org> <20060328170045.GA10334@gevaerts.be> <20060401170422.cc2ff8c2.khali@linux-fr.org> <20060403163541.GA4571@gevaerts.be> <20060408170238.4e241eac.khali@linux-fr.org> <20061011160745.605fc944.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011160745.605fc944.khali@linux-fr.org>
X-flash-is-evil: do not use it
X-virus: If this mail contains a virus, feel free to send one back
User-Agent: Mutt/1.5.9i
X-gevaerts-MailScanner: Found to be clean
X-MailScanner-From: fg@gevaerts.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 04:07:45PM +0200, Jean Delvare wrote:
> Hi Franck,
> 
> Quoting myself back in April:
> > > I just had a mail from another R52 user, reporting that his system
> > > (also 1846AQG) also reports ThinkPad H.
> > 
> > I gathered data on my side too, the three R52 I had reports for used
> > "ThinkPad R52" but these had different machine type/model. I guess that
> > the 1846AQG is somehow different, but probably you don't know why?
> > 
> > So I suppose we could add that "ThinkPad H" identifier string to the
> > hdaps driver after all, as you proposed in the first place. I'm only
> > worried that the "H" suffix is really short, and I hope that no other
> > model not supported by the driver (or needing the invert option) will
> > ever have the same identifier. Time will tell.
> 
> I am told that a newer BIOS of the Thinkpad R52 fixes the machine name
> in the DMI table.
> http://www.thinkwiki.org/wiki/List_of_DMI_IDs#R_series
> Can you please confirm this by upgrading the BIOS of your machine and
> removing the "ThinkPad H" entry from the hdaps driver?

BIOS 1.25 does indeed report "ThinkPad R52" instead of "ThinkPad H", and
hdaps without "ThinkPad H" works as expected.

Frank

> 
> Thanks,
> -- 
> Jean Delvare

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
