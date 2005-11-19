Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbVKSXEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVKSXEW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 18:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVKSXEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 18:04:22 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:54153 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751021AbVKSXEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 18:04:21 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Marc Perkel <marc@perkel.com>
Subject: Re: Does Linux support powering down SATA drives?
Date: Sat, 19 Nov 2005 23:04:16 +0000
User-Agent: KMail/1.9
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <437F63C1.6010507@perkel.com> <1132431907.19692.15.camel@localhost.localdomain> <437F9705.80503@perkel.com>
In-Reply-To: <437F9705.80503@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511192304.16302.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 November 2005 21:20, Marc Perkel wrote:
[snip]
>
> SATA isn't really "new" any more. I personally consider IDE to be
> obsolete. Seems to me that Linux should fully support SATA to the same
> level as IDE drives. And I'm saying that as someone who doesn't have to
> actually code it. But I will leave messages of praise and thanks in this
> mailing list if you all catch up.

As Alan mentions in another thread, what is needed is true hotplug support, 
which is difficult with some controllers for which we have poor (or no) 
documentation. I wouldn't hold your breath.

As for pass-thru standby/sleep commands, as long as the pass-thru patch got 
into mainline, try a very recent version of hdparm which should understand 
sending the ATA commands over SCSI (libata).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
