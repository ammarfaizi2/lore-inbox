Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUH1NLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUH1NLr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 09:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUH1NLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 09:11:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14560 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265808AbUH1NLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 09:11:43 -0400
Date: Sat, 28 Aug 2004 15:11:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Kenneth Lavrsen <kenneth@lavrsen.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pwc+pwcx is not illegal
Message-ID: <20040828131138.GZ12772@fs.tum.de>
References: <6.1.2.0.2.20040828141825.01e5e7d8@inet.uni2.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.2.0.2.20040828141825.01e5e7d8@inet.uni2.dk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 02:18:54PM +0200, Kenneth Lavrsen wrote:
> 
> >In the case of pwc+pwcx, pwcx (the decoder module) is completely useless
> >without pwc (the driver module), and thus is obviously falling in the
> >second class described above.
> 
> It was accepted for 4 years.
> And then suddenly is was crippled without a replacement - because of a 
> personal disagreement.

Which "personal disagreement"?

There was a hook for a binary-only module in the kernel, and as soon as 
Greg was made aware of it he removed it.

> This is the issue.
> Not the principle. Not the spirit of GPL which I support. I don't know why 
> so many of you always turn these debates into a matter of law and rules.
> 
> The issue that I keep on raising that that none of the kernel maintainers 
> will answer is.
> 
> - Do you care about the 10000s of users that you harm?
> - Do you care at all about anything else than yourself and your principles?

The policy in the kernel is quite liberal concerning non-free code 
(compare with e.g. the FSF and Debian).

I'd prefer it if non-GPL modules were completely forbidden, but although 
Linus stated himself that binary-only modules are a pain in the ass, 
they are tolerated in the Linux kernel.

> - Could this have been handled in a better way that would lead to the 
> pwc/pwcx being handled according to the new policy and so that the users 
> would not be affected?

Which "new policy"?

The fact that hooks for non-free modules are not allowed isn't new.

> Too many of you keep on defending bad behavour hiding behind the GPL.

If non-GPL modules were simply completely forbidden, there would be no  
reason for you to complain...

> When a commercial company sells something and cuts support too early - the 
> customers complain and stop buying more products from that supplier.
> Many companies have for this reason discovered that the only way to run a 
> successful business is to be driven by the "Total Customer Satisfaction" 
> principle.
> I am sure many of you are familiar with it from your daytime jobs.

Thankfully, the Linux kernel development is leaded by people for whom 
technical things are more important than marketing issues.

There are many examples like e.g. EVMS or the current reiser4 
discussion where "we really need it because of $important_reason" code 
isn't accepted as it is for this or that technical reason.

I might not always agree with a specific decision, but generally it 
leads in the long term to a better kernel.

> Kenneth

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

