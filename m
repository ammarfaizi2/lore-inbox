Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265899AbRF2NBl>; Fri, 29 Jun 2001 09:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265977AbRF2NBW>; Fri, 29 Jun 2001 09:01:22 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:29409 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S265899AbRF2NBO>; Fri, 29 Jun 2001 09:01:14 -0400
Message-ID: <3B3C7C13.E7A11B84@TeraPort.de>
Date: Fri, 29 Jun 2001 15:01:07 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac21 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: sbest@us.ibm.com
Subject: Re: Announcing Journaled File System (JFS) release 1.0.0 available
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 first of all congratulations for finishing the initial first release.
Some questions, just out of curiosity:


>* Fast recovery after a system crash or power outage 
>
>* Journaling for file system integrity 
>
>* Journaling of meta-data only 
>

 does this mean JSF/Linux always journals only the meta-data, or is that
an option?
Does it perform full data-journaling under AIX?

>* Extent-based allocation 
>
>* Excellent overall performance 
>
>* 64 bit file system 
>
>* Built to scale. In memory and on-disk data structures are designed to 
>  scale beyond practical limit 

 Is this scaling only for size, or also for performance (many disks on
many controllers) like XFS (at least on SGI iron)?

Thanks
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
