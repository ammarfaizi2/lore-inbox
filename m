Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267967AbTAHVGT>; Wed, 8 Jan 2003 16:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267968AbTAHVGO>; Wed, 8 Jan 2003 16:06:14 -0500
Received: from gordo.y12.doe.gov ([134.167.141.46]:50073 "EHLO
	gordo.y12.doe.gov") by vger.kernel.org with ESMTP
	id <S267967AbTAHVGK>; Wed, 8 Jan 2003 16:06:10 -0500
Message-ID: <3E1C94C5.6FB0EFBD@y12.doe.gov>
Date: Wed, 08 Jan 2003 16:14:45 -0500
From: David Dillow <dillowd@y12.doe.gov>
Organization: BWXT Y-12/TC/UT Subcon/What a mess!
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 3CR990 question (Nearly unrelated to iSCSI)
References: <200301081950.h08JoTr15738@buggy.badula.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> Actually, the 3Com driver I cleaned up does not have support for the
> hardware crypto chip. Maybe the other driver you were referring to
> supports it?

Yes, and no. It doesn't support it in the version I sent to Jeff. I do
have code that uses it, and a kludge to use it under 2.4. As for 2.5, I
hope to work to get it supported with the IPSEC code properly.

I do support the other offloading it will do -- VLAN, Checksum, and TCP
segmentation.

> > I hope we will see it appear in a kernel RSN
> 
> Indeed. :) That damn legalese in 3Com's license...

And government work! I've got the paperwork in progress, should be RSN
as Jeff said. Word is no later than next Wednesday, though I'm pushing
for Friday.

I've got the firmware under a BSD style license that will work for us,
and the driver is completely GPL.

Dave Dillow
dillowd@y12.doe.gov
