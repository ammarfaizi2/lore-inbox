Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317735AbSG3M1H>; Tue, 30 Jul 2002 08:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318244AbSG3M1H>; Tue, 30 Jul 2002 08:27:07 -0400
Received: from [62.70.58.70] ([62.70.58.70]:6814 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317735AbSG3M1G> convert rfc822-to-8bit;
	Tue, 30 Jul 2002 08:27:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Testing of filesystems
Date: Tue, 30 Jul 2002 14:30:33 +0200
User-Agent: KMail/1.4.1
References: <20020730094902.GA257@prester.freenet.de> <20020730082245.A1590@ti18>
In-Reply-To: <20020730082245.A1590@ti18>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207301430.33798.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What sort of tools _have_ been used to test JFS to date? and - what version(s) 
have been tested?

On Tuesday 30 July 2002 14:22, Bill Rugolsky Jr. wrote:
> On Tue, Jul 30, 2002 at 11:49:02AM +0200, Axel Siebenwirth wrote:
> > I wonder what a good way is to stress test my JFS filesystem. Is there a
> > tool that does something like that maybe? Dont't want performance
> > testing, just all kinds of stress testing to see how the filesystem "is"
> > and to check integrity and functionality.
>
> See the ext3 cvs tree at
>
>    http://sourceforge.net/projects/gkernel
>
> [Jeff Garzik's CVS tree hosts the ext3 tree.]
>
> Andrew Morton, being conscientious and methodical, has written lots of
> filesystem testing tools during his work on ext3.  Some of these tests
> are for specific ext3 regressions, but many are useful as general
> integrity tests oriented toward journalled filesystems.  He has also
> ported/improved several other tools, including a bunch of changes to
> the notorious FSX, the File System eXerciser.
>
> The Namesys folks also have a test suite for Reiserfs, see www.namesys.com.
>
> Regards,
>
>    Bill Rugolsky
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

