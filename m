Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130072AbQKKIYo>; Sat, 11 Nov 2000 03:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130123AbQKKIYe>; Sat, 11 Nov 2000 03:24:34 -0500
Received: from ozone.fmi.fi ([193.166.223.16]:38697 "EHLO ozone.fmi.fi")
	by vger.kernel.org with ESMTP id <S130072AbQKKIYW>;
	Sat, 11 Nov 2000 03:24:22 -0500
From: "Kari E. Hurtta" <Kari.Hurtta@ozone.FMI.FI>
Message-Id: <200011110823.eAB8Nxc354799@ozone.fmi.fi>
Subject: [OFF] Load avarage (Re: sendmail fails to deliver mail with attachments
 in /var/spool/mqueue)
In-Reply-To: <20001110142547.F16213@sendmail.com> "from Claus Assmann at Nov
 10, 2000 02:25:47 pm"
To: sendmail <sendmail@sendmail.org>
Date: Sat, 11 Nov 2000 10:23:58 +0200 (EET)
CC: David Lang <david.lang@digitalinsight.com>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        linux-kernel@vger.kernel.org
Reply-To: sendmail <sendmail@sendmail.org>
X-Mailer: ELM [version 2.4ME+ PL83 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claus Assmann:
> Why does Linux report a LA of 10 if there are only two processes
> running?

[This goes out of subject]

I have learned that load avarage means

	"Processes on run queue" + 
	"process waiting disk (or short-term) I/O"

That was before Linux times.

I have seen a workstation go to show load-average 100.
That happened when NFS-server (or network) died. These
workstations were diskless, so all processes ended to
waiting of "disk" I/O.

These were Sun's diskless workstation models.

So it is not new that load average includes something else than
processes waiting for CPU.

/ Kari Hurtta

(That was on Computer Science department of University of Helsinki.)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
