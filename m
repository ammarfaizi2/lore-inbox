Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319717AbSIMRGR>; Fri, 13 Sep 2002 13:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319715AbSIMRGR>; Fri, 13 Sep 2002 13:06:17 -0400
Received: from madhouse.demon.co.uk ([158.152.8.97]:31187 "EHLO
	madhouse.demon.co.uk") by vger.kernel.org with ESMTP
	id <S319712AbSIMRGP>; Fri, 13 Sep 2002 13:06:15 -0400
To: <linux-kernel@vger.kernel.org>
From: abuse@madhouse.demon.co.uk (Andrew Bray)
Subject: Re: [PATCH] drivers/pci,hamradio,scsi,aic7xxx,video,zorro clean and mrproper files 4/6
Date: 13 Sep 2002 15:49:01 GMT
Organization: Private Internet Node
Message-ID: <slrnao427d.si3.abuse@madhouse.demon.co.uk>
References: <20020910225530.A17094@mars.ravnborg.org> <20020910230656.D18386@mars.ravnborg.org> <9500000.1031706478@aslan.btc.adaptec.com> <20020911071219.A1352@mars.ravnborg.org>
Reply-To: andy@@chaos.org.uk
X-Trace: madhouse.demon.co.uk 1031932141 24329 127.0.0.1 (13 Sep 2002 15:49:01 GMT)
X-Complaints-To: news@madhouse.demon.co.uk
NNTP-Posting-Date: 13 Sep 2002 15:49:01 GMT
User-Agent: slrn/0.9.6.4 (Linux)
In-Reply-To: <20020911071219.A1352@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002 07:12:19 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
>On Tue, Sep 10, 2002 at 07:07:58PM -0600, Justin T. Gibbs wrote:
>> > +# Files generated that shall be removed upon make clean
>> > +clean := aic7xxx_seq.h aic7xxx_reg.h
>> 
>> At lease this line need to be contingent on the actual building of
>> firmware.  Otherwise you've just blown away the firmware the vendor
>> has shipped with the system and the user may not have the utilities
>> to rebuild it.
>The original firmware are stored in files named:
>aic7xxx_reg.h_shipped  aic7xxx_seq.h_shipped
>They are copied to aic7xxx_seq.h aic7xxx_reg.h during the build.
>So no problem here.

Just a thought: should 'make clean' and/or 'make mrproper' rename the
_shipped files back to their origilal names?

Regards,

Andy

-- 
-----------------------------------------------------------------------------
Andrew Bray, PWMS, MA,              |  preferred:    mailto:andy@chaos.org.uk
London, England                     |  or:   mailto:andy@madhouse.demon.co.uk
PGP id/fingerprint:  D811F5C9/26 B5 42 C6 F4 00 B2 71 BA EA 9B 81 6C 65 59 07

