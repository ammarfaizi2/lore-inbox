Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264412AbRFIAAk>; Fri, 8 Jun 2001 20:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264410AbRFIAA3>; Fri, 8 Jun 2001 20:00:29 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:47099 "EHLO
	e34.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264409AbRFIAAV>; Fri, 8 Jun 2001 20:00:21 -0400
Importance: Normal
Subject: Re: question about scsi generic behavior
To: hiren_mehta@agilent.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFD495CEA8.42F18603-ON88256A65.00827EA4@LocalDomain>
From: "David Chambliss" <chamb@almaden.ibm.com>
Date: Fri, 8 Jun 2001 16:49:29 -0700
X-MIMETrack: Serialize by Router on D03NM042/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 06/08/2001 04:59:00 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think you need to set bpt=8 .

It is possible to set some drives to block sizes other than 512 bytes, and
hardcoding 512 is not a good idea, especially in code that might last a
while.  In a few years we might have 4096-byte blocks to let the drives use
more powerful error correcting codes.

David Chambliss
Research Staff Member, Computer Science /Storage Systems
IBM Research Division
(408) 927-2243  (TL 457-2243)
FAX (408) 927-3497

