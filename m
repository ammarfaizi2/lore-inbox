Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTHaHyd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 03:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbTHaHyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 03:54:32 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:49042 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261966AbTHaHy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 03:54:27 -0400
Date: Sun, 31 Aug 2003 04:52:20 -0300
From: Gerardo Exequiel Pozzi <djgeray2k@yahoo.com.ar>
To: Jeff Chua <jeff89@silk.corp.fedex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] hda:end_request: I/O error, dev 03:00 (hda), sector 0
Message-Id: <20030831045220.3ace5a34.djgeray2k@yahoo.com.ar>
In-Reply-To: <Pine.LNX.4.42.0308311221430.17575-100000@silk.corp.fedex.com>
References: <Pine.LNX.4.42.0308311221430.17575-100000@silk.corp.fedex.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Aug 2003 12:24:29 +0800 (SGT), Jeff Chua wrote:
>
>What do I need to get rid of these errors ...
>
>dmesg after boot up ...
>
*snip*
>Partition check:
> hda:end_request: I/O error, dev 03:00 (hda), sector 0
>end_request: I/O error, dev 03:00 (hda), sector 2
>end_request: I/O error, dev 03:00 (hda), sector 4
>end_request: I/O error, dev 03:00 (hda), sector 6
>end_request: I/O error, dev 03:00 (hda), sector 0
>end_request: I/O error, dev 03:00 (hda), sector 2
>end_request: I/O error, dev 03:00 (hda), sector 4
>end_request: I/O error, dev 03:00 (hda), sector 6
> unable to read partition table

I suppose that your disk will be in good state, ok,
A time ago I had the same error (with hdc), and was that had forgotten
to clear the hdc=ide-scsi from of the line append in lilo.

Possibly it is your problem, although it is strange to me with hda.

Please check your command line at boot, and remove the bad apppend line in lilo.conf

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
