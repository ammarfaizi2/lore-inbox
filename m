Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316456AbSFDTTM>; Tue, 4 Jun 2002 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316616AbSFDTTL>; Tue, 4 Jun 2002 15:19:11 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:60665 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316456AbSFDTTL>; Tue, 4 Jun 2002 15:19:11 -0400
Subject: Re: [OT] Re: please kindly get back to me
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: J Sloan <jjs@lexus.com>
Cc: Hank Leininger <hlein@progressive-comp.com>,
        linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFD0899.6040402@lexus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 21:24:35 +0100
Message-Id: <1023222275.6773.182.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 19:36, J Sloan wrote:
> Complacency is never a good idea - however,
> let's give credit where credit is due - it's orders
> of magnitude more difficult to do something like
> this against a unix system - most script kiddies
> will go for the easy targets (microsoft) instead

Each of the major viruses has probably got one author singular.

There are ways of making systems much more resistant to attack including
viruses. Things like RSBAC and the NSA security modules help you get
into a situation where this kind of stuff doesn't occur

	User1 gets a virus
	User1 owns a binary root users
	Root gets the virus
	Splat

Because with a trust model it goes instead

	User1 geta a virus
	User1 owns a binary root users
	User1 virus patches the binary

	Root is refused permission to run the binary because it no 	longer has
a high enough integrity

Even before that the lack of people checking GPG keys on RPM and other
packages is disturbing. 

Alan

