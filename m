Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSFDO1y>; Tue, 4 Jun 2002 10:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSFDO1x>; Tue, 4 Jun 2002 10:27:53 -0400
Received: from [62.245.135.174] ([62.245.135.174]:47284 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S312619AbSFDO1v> convert rfc822-to-8bit;
	Tue, 4 Jun 2002 10:27:51 -0400
From: "Martin.Knoblauch" <Martin.Knoblauch@teraport.de>
Reply-To: Martin.Knoblauch@teraport.de
Organization: TeraPort GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre9-ac3: Build problem
Date: Tue, 4 Jun 2002 16:27:45 +0200
User-Agent: KMail/1.4.1
In-Reply-To: <200206040935.34870.Martin.Knoblauch@teraport.de>
MIME-Version: 1.0
Message-Id: <200206041627.45953.Martin.Knoblauch@teraport.de>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 06/04/2002 04:27:45 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 06/04/2002 04:27:52 PM,
	Serialize complete at 06/04/2002 04:27:52 PM
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 June 2002 09:35, Martin.Knoblauch wrote:
>
>  This works fine. Next I make a change to the configuration (any change)
> and do
>
> make dep clean
> make bzimage
>
>  bzImage fails with:
>

 a kind soul pointed out that I should do:

make clean dep
make bzimage

instead. Works. Learned a new trick :-)

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759

