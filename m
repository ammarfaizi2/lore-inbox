Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316872AbSEVGbN>; Wed, 22 May 2002 02:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316873AbSEVGbM>; Wed, 22 May 2002 02:31:12 -0400
Received: from mail025.syd.optusnet.com.au ([210.49.20.147]:11202 "EHLO
	mail025.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S316872AbSEVGbL>; Wed, 22 May 2002 02:31:11 -0400
Date: Wed, 22 May 2002 16:34:08 +1000
From: Andrew Pam <xanni@glasswings.com.au>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initialisation bug in IDE patch
Message-ID: <20020522163408.H2437@kira.glasswings.com.au>
In-Reply-To: <20020522161144.G2437@kira.glasswings.com.au> <Pine.LNX.4.10.10205212313160.19403-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 11:18:56PM -0700, Andre Hedrick wrote:
> Now you have me puzzled........
> If "ide_setup" which parses the passed settings calls "init_ide_data"
> which initalizes all "hwif" groups and sets a cookie to prevent "ide_init"
> from re-initalizing thus purging the contents place in by "ide_setup", how
> are you getting a "BAD -- OPTION"?
> 
> Would please post what you are attempting to pass ?

"ide0=qd6580"

Don't tell me, you're going to want me to put all my printk debugging
back in and show exactly where the data remains uninitialised...

Cheers,
	Andrew Pam
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Technology Manager, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
http://two-cents-worth.com/?105347&EG		Donate two cents to our work!
P.O. Box 477, Blackburn VIC 3130 Australia	Phone +61 401 258 915
