Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130431AbRAVCCB>; Sun, 21 Jan 2001 21:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130648AbRAVCBw>; Sun, 21 Jan 2001 21:01:52 -0500
Received: from typhoon.mail.pipex.net ([158.43.128.27]:56269 "HELO
	typhoon.mail.pipex.net") by vger.kernel.org with SMTP
	id <S130431AbRAVCBh>; Sun, 21 Jan 2001 21:01:37 -0500
To: linux-kernel@vger.kernel.org
From: Trevor-Hemsley@dial.pipex.com (Trevor Hemsley)
Date: Mon, 22 Jan 2001 02:00:47
Subject: Re: Incorrect module init message..
X-Mailer: ProNews/2 V1.51.ib103
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010122020147Z130431-18594+148@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001 09:09:01, "Mike A. Harris" 
<mharris@opensourceadvocate.org> wrote:

> 1 root@asdf:/# mcdr
> Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 6x/6x writer cd/rw xa/form2 cdda tray
>                       ^^^^^
>  
> HP7200i burner 2x/2x/6x  (CDR/CDRW/read)
>  
> Don't know if anyone cares to fix the message..

The message is reporting current/maximum read speeds. There's no 
indication that this is or is not what was intended to be reported. If
it was intended to be max write/read speeds then it should be using 
the two bytes at +18 and 19 of mode page 2a not the ones at +14 and 
15.

-- 
Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
