Return-Path: <linux-kernel-owner+w=401wt.eu-S1752957AbWLWJhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbWLWJhx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 04:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbWLWJhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 04:37:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1183 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752793AbWLWJhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 04:37:32 -0500
Date: Sat, 23 Dec 2006 08:54:59 +0000
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network drivers that don't suspend on interface down
Message-ID: <20061223085458.GE3960@ucw.cz>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191959.43019.david-b@pacbell.net> <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de> <20061220055209.GA20483@srcf.ucam.org> <1166601025.3365.1345.camel@laptopd505.fenrus.org> <20061220125314.GA24188@srcf.ucam.org> <1166621931.3365.1384.camel@laptopd505.fenrus.org> <20061220143134.GA25462@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220143134.GA25462@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > about your driver list;
> > do you have an idea of what the top 5 relevant ones would be?
> > I'd be surprised if the top 5 together had less than 95% market share,
> > so if we fix those we'd be mostly done already.
> 
> In terms of what I've seen on vaguely modern hardware, I'd guess at 
> e1000 and sky2 as the top ones. b44 is still common in cheaper hardware, 

e1000 already powersaves when cable is not plugged in. Difference is
~0.5W, IIRC.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
