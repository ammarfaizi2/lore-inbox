Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263933AbRFSH2R>; Tue, 19 Jun 2001 03:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263958AbRFSH2H>; Tue, 19 Jun 2001 03:28:07 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:6895 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S263933AbRFSH17>; Tue, 19 Jun 2001 03:27:59 -0400
Message-ID: <3B2EFEEE.18DEEC02@TeraPort.de>
Date: Tue, 19 Jun 2001 09:27:42 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac13 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jonathan Morton <chromi@cyberspace.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VM: Buffer vs. Cache
In-Reply-To: <l0313032ab74670af4963@[192.168.239.105]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton wrote:
> 
> >
> > So, what actually is the difference between Buffered and Cached.
> >Apparently quite a lot of the pages that are Cached in the evening are
> >Buffered 9 houres later.
> 
> Think about what happens in the meantime.  Most distros install maintenance
> scripts which run late at night (usually at midnight and/or 4am), which
> perform heavy disk activity as they update databases and scan for
> file-permissions security holes.  Heavy disk activity usually means an
> increase in buffer utilisation.  Since most files are only "touched" once,
> the cache is shrunk as it aren't being used very much.
> 

 thanks to all who set me straight. Should have thought of the nightly
stuff myself.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
