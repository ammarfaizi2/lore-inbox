Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276826AbRJZAM5>; Thu, 25 Oct 2001 20:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276831AbRJZAMr>; Thu, 25 Oct 2001 20:12:47 -0400
Received: from peacekeeper.artselect.com ([208.145.206.90]:2728 "EHLO
	davinci.artselect.com") by vger.kernel.org with ESMTP
	id <S276826AbRJZAMi>; Thu, 25 Oct 2001 20:12:38 -0400
From: Pete Harlan <harlan@artselect.com>
Date: Thu, 25 Oct 2001 19:13:12 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.13 hangs writing to scsi tape
Message-ID: <20011025191312.A12751@artselect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.13 and .13-pre6 hang when I try to write to the tape drive.
2.4.10 is fine.  ("Hung" == machine does not respond to ping.)

Dual PIII, eepro100, Adaptec 2930CU onboard SCSI.  Ecrix tape drive is
on 1st channel, hard disk (reiserfs) is on the other channel.

No messages saved in log; I didn't have time to hook up a screen, as
the machine is very heavily used.  If desired, I can warn our folks,
come in at night and repeat it to see what shows up on the console.

Thanks,

--Pete

[gcc 2.95.4, Debian Woody, fresh 2.4.13 tarball.]
