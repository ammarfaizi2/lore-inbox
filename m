Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWDHQxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWDHQxd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 12:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWDHQxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 12:53:33 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:31201 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S965023AbWDHQxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 12:53:32 -0400
Date: Sat, 8 Apr 2006 18:53:03 +0200
From: Frank Gevaerts <frank@gevaerts.be>
To: Jean Delvare <khali@linux-fr.org>
Cc: Robert Love <rlove@rlove.org>, linux-kernel@vger.kernel.org
Subject: Re: patch : hdaps on Thinkpad R52
Message-ID: <20060408165303.GA18524@gevaerts.be>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	Robert Love <rlove@rlove.org>, linux-kernel@vger.kernel.org
References: <20060314205758.GA9229@gevaerts.be> <20060328182933.4184db3f.khali@linux-fr.org> <20060328170045.GA10334@gevaerts.be> <20060401170422.cc2ff8c2.khali@linux-fr.org> <20060403163541.GA4571@gevaerts.be> <20060408170238.4e241eac.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408170238.4e241eac.khali@linux-fr.org>
X-flash-is-evil: do not use it
X-virus: If this mail contains a virus, feel free to send one back
User-Agent: Mutt/1.5.9i
X-gevaerts-MailScanner: Found to be clean
X-MailScanner-From: fg@gevaerts.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2006 at 05:02:38PM +0200, Jean Delvare wrote:
> Hi Franck,
> 
> Sorry for the late answer...
> 
> > > OK, so as strange as it sounds, that's really the string as stored in
> > > the DMI table. How odd... You have to understand that I'm a bit
> > > reluctant to adding it officially to the hdaps driver, given that it
> > > clearly looks like a bogus table in your laptop. I guess that you only
> > > have one laptop with this string?
> > 
> > I just had a mail from another R52 user, reporting that his system
> > (also 1846AQG) also reports ThinkPad H.
> 
> I gathered data on my side too, the three R52 I had reports for used
> "ThinkPad R52" but these had different machine type/model. I guess that
> the 1846AQG is somehow different, but probably you don't know why?

No.

> So I suppose we could add that "ThinkPad H" identifier string to the
> hdaps driver after all, as you proposed in the first place. I'm only
> worried that the "H" suffix is really short, and I hope that no other
> model not supported by the driver (or needing the invert option) will
> ever have the same identifier. Time will tell.

If it turns out to be a problem, the best solution might be to also
(optionally) check the 'Product Name' field. I don't know how hard this
would be.

Frank

> Thanks,
> -- 
> Jean Delvare

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
