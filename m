Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271831AbRIEH7Z>; Wed, 5 Sep 2001 03:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271827AbRIEH7E>; Wed, 5 Sep 2001 03:59:04 -0400
Received: from smtp.mediascape.net ([212.105.192.20]:13060 "EHLO
	smtp.mediascape.net") by vger.kernel.org with ESMTP
	id <S271822AbRIEH66>; Wed, 5 Sep 2001 03:58:58 -0400
Message-ID: <3B95DB22.866EDCA3@mediascape.de>
Date: Wed, 05 Sep 2001 09:58:26 +0200
From: Olaf Zaplinski <o.zaplinski@mediascape.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.9-ac6 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: joe.mathewson@btinternet.com
CC: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors
In-Reply-To: <200109050621.f856LAK00824@ambassador.mathewson.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Mathewson wrote:
> 
> I've just woken up this morning to find my internet gateway machine only
> responding to pings, and on giving it a keyboard & monitor, a load of
> 
> scsi0:0:1:0: Attempting to queue an ABORT message
> scsi0:0:1:0: Cmd aborted from QINFIFO
> aic7xxx_abort returns 8194
> 
> errors.
[...]

/me too. I had this while booting 2.4.9 with a fresh installed SCSI card
(AHA2940) + harddisk. What worked for me was to compile the kernel with the
old Adaptec driver, so it's a driver issue.

Olaf
