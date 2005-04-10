Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVDJUgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVDJUgS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 16:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVDJUgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 16:36:18 -0400
Received: from smtp805.mail.ukl.yahoo.com ([217.12.12.195]:8371 "HELO
	smtp805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261599AbVDJUgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 16:36:11 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Stas Sergeev <stsp@aknet.ru>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: formatting CD-RW locks the system
Date: Sun, 10 Apr 2005 21:36:09 +0100
User-Agent: KMail/1.8
References: <42597088.9050004@aknet.ru>
In-Reply-To: <42597088.9050004@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504102136.09229.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 Apr 2005 19:29, you wrote:
> Hello.
>
> I am trying to format the CD-RW disc
> on my NEC ND-3520A DVD writer, and the
> results are completely unexpected: I do
> cdrwtool -d /dev/cdrom -q
> It proceeds with the formatting, but
> while it does so, the system is pretty
> much dead. It can do some trivial tasks
> like the console switching, but as soon
> as it comes to any disc I/O, the processes
> are hanging. After the formatting is done,
> the system is back alive. That reminds me
> formatting the floppies under DOS in those
> ancient times, with the only difference
> that formatting a floppy takes ~2 minutes,
> while formatting a CD-RW takes ~20 minutes,
> which is not good at all.
> Is this something known or a bug?
> I tried that on a 2.6.11-rc3-mm2 and
> on a 2.6.12-rc1 kernels.
>
> Also, is there any way to use the
> packet writing with the CD-R/DVD-R discs,
> or is it supposed to work only with the
> -RW discs?

You probably don't have DMA enabled on the drive. Please check this.

CDRW formatting works fine here with cdrecord blank=all

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
