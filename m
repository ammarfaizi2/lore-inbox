Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265435AbSKFAju>; Tue, 5 Nov 2002 19:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSKFAju>; Tue, 5 Nov 2002 19:39:50 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:11456 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265435AbSKFAjs>;
	Tue, 5 Nov 2002 19:39:48 -0500
Importance: Normal
Sensitivity: 
Subject: Re: RE2: [Evms-devel] EVMS announcement
To: "Michael Nguyen" <michael.nguyen@corosoft.com>
Cc: <evms-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OF9B0C3155.FEB10444-ON85256C69.000322F8@pok.ibm.com>
From: "Steve Pratt" <slpratt@us.ibm.com>
Date: Tue, 5 Nov 2002 20:09:42 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and RM_DEBUG |October 24, 2002) at 11/05/2002 07:46:03 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Nguyen wrote:
>This is one sad :( email to read, and Im sure it's
>even more difficult to write. There can't be any winner
>when public domain refuses a given work. I commend your
>past and your continuing development effort.

Yes, this was a hard decision to make, but we honestly feel it
is the right long term answer for EVMS users.

>Near term:
>1. How long will EVMS1.2.0 & kernel2.4 be supported?

2 answers: 1.2.x on 2.4 will be supported for a long time.  I never
like to give real dates on items like this, but we won't leave current
users hanging.

For 2.4 in general, in addition to supporting 1.2.x we will also be
offering
EVMS 2.0 (new design) on 2.4 as well as 2.5.

>Looking further out:
>1. Is EVMS runtime a throw away?

Mostly yes. Some stuff like BBR will survive but for the most part it's
going away.

>2. Is EVMS engine to modify for LVM2 support?

LVM2 is a set of user tools to get LVM1 functions on Device Mapper.
The EVMS Engine will also use device mapper to provide LVM1 capabilities
and backwards compatibility (as well as lots of other stuff).
The LVM2 tools will not be required.

>3. What will happen to the modular (plugins)?
     >- AIX LVM
     >- OS2 LVM

     These stay around as Engine plug-ins either using device mapper as the
     kernel side or if necessary some other kernel driver.  EVMS will
     continue
     to offer OS/2 and AIX migration support.

     >- Device manager (local/san)

     Unsure, we never really found a use for the san device manager as
     san device come in looking like scsi disks in most cases.

     >- etc..

     As stated in numerous other appends, EVMS is not dropping support
     for any plug-ins.  All EVMS volumes should be transparently
     accessible under the new design.


 Steve


