Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSGHSOh>; Mon, 8 Jul 2002 14:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSGHSOh>; Mon, 8 Jul 2002 14:14:37 -0400
Received: from ausadmmsrr503.us.dell.com ([143.166.83.90]:1803 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S317024AbSGHSOg>; Mon, 8 Jul 2002 14:14:36 -0400
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <F44891A593A6DE4B99FDCB7CC537BBBB072469@AUSXMPS308.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: dtroth@bellsouth.net, linux-kernel@vger.kernel.org
Subject: RE: DELL array controller access.
Date: Mon, 8 Jul 2002 13:17:09 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 113708A21303374-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a DELL PowerEdge XE 51.  It has a DELL array 
> controller running 
> on EISA buss.  The controller is uses a AHA-154x emulation.  
> I am using 
> RedHat 7.0 and it does not see the board.  Where can I get a 
> EISA buss AHA-154x driver to access the array controller?

David, Dell never produced a Linux device driver for the Dell SCSI Array
card.  I had forgotten about the AHA-154x emulation feature, but since it
doesn't seem to work, it's unlikely that it ever will.  Everyone who worked
on that project 9 years ago has left for other opportunities.  The on-board
NCR SCSI controller should still work, and you can use software RAID quite
easily to accomplish similar functionality.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

