Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275068AbRIYQSM>; Tue, 25 Sep 2001 12:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275066AbRIYQSD>; Tue, 25 Sep 2001 12:18:03 -0400
Received: from mail.teraport.de ([195.143.8.72]:37519 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S275068AbRIYQRx>;
	Tue, 25 Sep 2001 12:17:53 -0400
Message-ID: <3BB0AE43.BC36820F@TeraPort.de>
Date: Tue, 25 Sep 2001 18:18:11 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: riel@conectiva.com.br
Subject: Re: 2.4.10 much better than previous 2.4.x :-)
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 09/25/2001 06:18:11 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 09/25/2001 06:18:19 PM,
	Serialize complete at 09/25/2001 06:18:19 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: 2.4.10 much better than previous 2.4.x :-)
> 
> 
> On 24 Sep 2001, Michael Rothwell wrote:
> 
> > This is mainly a thank you for 2.4.10. It performs much better than
> > 2.4.7 (RedHat version), from which I upgraded. Interactive performance
> > for applications (Gnome, Evolution, Mozilla) is much improved,
> 
> If you have the time, could you also test 2.4.9-ac15 ?
> 
> (The -ac VM has basically branched off at 2.4.7 and has
> evolved quite a bit since ... last week I fixed a stupid
> page aging bug and things should be a lot better than
> before now)
> 
> regards,
> 
> Rik
> 
Rik,

 just did a short test with both 2.4.9-ac15 and 2.4.10 plain on a
Notebook with 320 MB and twice as much swap. "/" is on reiserfs.

 Both look a lot better that anything before. With my workload of
netscape, NT_under_vmware (128 MB memory) and a kernel compile I am not
using swap for the first time since in 2.4.x.

 My feeling is that 2.4.10 behaves a bit better with high I/O activity
on the reiserfs partition. Maybe this can be attributed to the latest
reiserfs stuff that went into 2.4.10, but not yet in -ac. The
responsiveness when "suspending" the vmware session has definitely
improved with 2.4.10. With 2.4.9-ac the system "freezes" for some
seconds during that operation.

 In any case, good work in both trees.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
