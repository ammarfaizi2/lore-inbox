Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVBGS3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVBGS3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 13:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVBGS3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:29:31 -0500
Received: from web30206.mail.mud.yahoo.com ([68.142.200.89]:34964 "HELO
	web30206.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261224AbVBGS3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:29:22 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=McEzWFDzILcQRGCR2vLeF7sDRgaygfgmAWWMYhRxH0JV90m0/jv6siHbF61lPLMMnggIvC5pkcUuSD3ZFTmYpC3HMwIAbrIvTTKlFSME5LkEslOcHz/3yOAU0/Ga+B77dbKu+wW39DXRm2ovlTpb05pZrija/mOQTK0Ln4AbsWg=  ;
Message-ID: <20050207182921.3015.qmail@web30206.mail.mud.yahoo.com>
Date: Mon, 7 Feb 2005 10:29:21 -0800 (PST)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1107701373.22680.115.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Arjan van de Ven <arjan@infradead.org> wrote:

> 
> > I consider it not a new feature, but a missing feature, since
> otherwise 
> > user data cannot be accessed in the RAID setups.
> 
> the same is true for all new hardware drivers and hardware support
> patches. And for new DRM (since new X may need it) and new .. and
> new ... where is the line?
> 
> for me a deep maintenance mode is about keeping existing stuff
> working;
> all new hw support and derivative hardware support (such as this) can
> be
> pointed at the new stable series... which has been out for quite some
> time now..

Would it help my case if I swore that iswraid has been released
for longer than the "new stable series" and that it is in "deep
maintenance mode" itself, just outside the 2.4 kernel tree?
(Version 0.0.6 (for 2.4.22) was announced Nov. 24, 2003.) 
 
I do realize that Intel should have asked a long time ago for it
to be considered for acceptance (I did ask back in October for
2.4.28). But there are positive aspects to accepting a driver
late---there is a much higher chance that all the issues have
been solved. (If there are any particular worries about the
newly added RAID1E code, well, it's only useful for ICH7R, I'd
be almost as happy if an older version without it got accepted.)

To conclude, Marcelo's words back in October 9 were:
  "New drivers are OK, as long as they don't break existing setups, 
  and if substantial amount of users will benefit from it."
So here is a "new driver" (that's been around for a while)
which I don't think can break anything. As to the "substantial
amount of users", the two SourceForge releases with download
statistics have each seen about 800 downloads, I have no idea
whether that counts as substantial.

  Martins Krikis
  Storage Components Division
  Intel Massachusetts







		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 
