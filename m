Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbSJAQaI>; Tue, 1 Oct 2002 12:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261710AbSJAQaI>; Tue, 1 Oct 2002 12:30:08 -0400
Received: from signup.localnet.com ([207.251.201.46]:6627 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S261709AbSJAQaH>;
	Tue, 1 Oct 2002 12:30:07 -0400
To: Markus Weiss <mweiss38@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
References: <8556.1033472350@www19.gmx.net>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <8556.1033472350@www19.gmx.net>
Date: 01 Oct 2002 12:35:26 -0400
Message-ID: <m3bs6e2k35.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> "Markus" == Markus Weiss <mweiss38@gmx.net> writes:

Markus> I also would love to test on my laptop (especially because of
Markus> ACPI), but I have / on LVM :-(
 
I got this reply to my recent, similar note:

-JimC


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline

From: Daniel Berlin <dberlin@dberlin.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Subject: Re: ide-scsi, 1394-sbp2 and usb-storage scsi host ids
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Date: Mon, 30 Sep 2002 00:28:19 -0400 (EDT)

> I can't test 2.5 on this box, as /home, /opt, /tmp, /usr, /var and
> swap are all in LVM1.

Use EVMS CVS with 2.5, and enable the LVM support it includes.

Works great for me under 2.5.38.

You just have to remember to mount (or set up devfsd/whatever to 
create the right symlinks for you) /dev/evms/lvm/<whatever> instead of 
/dev/<whatever>.

--Dan

--=-=-=--

