Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132481AbRCZQmx>; Mon, 26 Mar 2001 11:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132479AbRCZQmo>; Mon, 26 Mar 2001 11:42:44 -0500
Received: from gear.torque.net ([204.138.244.1]:59149 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S132477AbRCZQm3>;
	Mon, 26 Mar 2001 11:42:29 -0500
Message-ID: <3ABF71A1.99D041E1@torque.net>
Date: Mon, 26 Mar 2001 11:43:13 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac24 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Dale E Martin <dmartin@cliftonlabs.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: ext2 corruption in 2.4.2, scsi only system
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dale E Martin wrote:
> [snip]
> I had had good luck with 2.4.x on other boxes, so I put it 
> on this machine as well.  Several times now I've seen ext2 
> corruption with no other noteworthy logs.
> .....
> The machine is a dual PPro, it has a Buslogic BT958 with a 
> single 9G scsi/wide drive in it.
> ....

Dale,
Alan Cox has reported the following:

> 2.4.2-ac19
> .......
> o       Hopefully fix the buslogic corruptions          (me)

Alan's ac tree also contains a consolidated set of
patches from Eric Youngdale for the SCSI midlevel.
Alan's latest is ac25 and may be worth trying (ac24
has been working fine for me).

Doug Gilbert
