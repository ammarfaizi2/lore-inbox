Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312644AbSCVDJz>; Thu, 21 Mar 2002 22:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312646AbSCVDJg>; Thu, 21 Mar 2002 22:09:36 -0500
Received: from web14204.mail.yahoo.com ([216.136.172.146]:53602 "HELO
	web14204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312644AbSCVDJQ>; Thu, 21 Mar 2002 22:09:16 -0500
Message-ID: <20020322030914.51768.qmail@web14204.mail.yahoo.com>
Date: Thu, 21 Mar 2002 19:09:14 -0800 (PST)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: Raid 5 & linux 2.5.x
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've noticed that RAID5 needs porting from BH's to BIO's.  Where would one
start if interested in doing this.  I notice that one would need to change the
arrays of BH's in the raid5 struct in raid5.h, as well as renaming several
other variables which currently have md_ prepended to the beginning.  This
leaves all the BH handling code in raid5.c.  Does this require algorithm
changes, or is it basically replace bh code for simmilar code using bio's?

TIA
Erik McKee

__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
