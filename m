Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTJQNEf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 09:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263456AbTJQNEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 09:04:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11027 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263453AbTJQNEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 09:04:33 -0400
Date: Fri, 17 Oct 2003 14:04:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Message-ID: <20031017140428.B2415@flint.arm.linux.org.uk>
Mail-Followup-To: Norman Diamond <ndiamond@wta.att.ne.jp>,
	Hans Reiser <reiser@namesys.com>,
	Wes Janzen <superchkn@sbcglobal.net>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
	nikita@namesys.com, Pavel Machek <pavel@ucw.cz>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60> <3F8FBADE.7020107@namesys.com> <126d01c3949f$91bdecc0$3eee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <126d01c3949f$91bdecc0$3eee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Fri, Oct 17, 2003 at 08:11:42PM +0900
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 08:11:42PM +0900, Norman Diamond wrote:
> Russell King replied to me:
> > > When a drive tries to read a block, if it detects errors, it retries up
> > > to 255 times.  If a retry succeeds then the block gets reallocated.  IF
> > > 255 RETRIES FAIL THEN THE BLOCK DOES NOT GET REALLOCATED.
> >
> > This is perfectly reasonable.  If the drive can't recover your old data
> > to reallocate it to a new block, then leaving the error present until you
> > write new data to that bad block is the correct thing to do.

Why the F**K are you replying to me publically when I sent my reply in
private?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
