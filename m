Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTKCEmC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 23:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTKCEmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 23:42:02 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:7588 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261892AbTKCEl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 23:41:59 -0500
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="Big5"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.2  (F2.71; T1.001; A1.51; B2.12; Q2.03)
From: "CN" <cnliou9@fastmail.fm>
To: linux-kernel@vger.kernel.org
Date: Sun, 02 Nov 2003 20:41:55 -0800
X-Sasl-Enc: 8p9OrLBiaTYGuujIlqKsVg 1067834515
Subject: Re: kernel: i8253 counting too high! resetting..
References: <20031029075010.596C57A6C6@smtp.us2.messagingengine.com>
  <20031030171235.GA59683@teraz.cwru.edu>
  <20031031050439.E03B17E2B8@smtp.us2.messagingengine.com>
  <200310310040.19519.gene.heskett@verizon.net> <20031031063636.GA61826@teraz.cwru.edu>
In-Reply-To: <20031031063636.GA61826@teraz.cwru.edu>
Message-Id: <20031103044155.8D0067DF67@server2.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003 06:36:36 +0000, "Dan Bernard" <djb29@cwru.edu> said:
> ALi M1542 chipset is probably not too different from mine.  That's good,
> because if it were not ALi, then this would be much more complicated.
> 
> The main problem here is not any kind of malfunction, but simply a
> component or group of components performing slightly below what is
> expected, and the software therefore generates unnecessary noise.
> 
> I do not try to tweak any settings with hdparm unless something is
> broken.
> However, it looks like that may be your best bet in this particular case.
> I shall just continue putting up with the warnings for now.
> 
> Still, if anyone gets these warnings without ALi chipsets, please do
> tell.

I'm sorry for the late follow up as I lost Internet connection during the
period of OS reinstallation. The following symptom I have newly noticed
is a follow up to my first post in this thread.

As reported in my first message, the box running kernel 2.4.22 and
Fjuitsu HD generated i8253 message while the other box running 2.4.20 and
Maxtor did not. During the past 3 days I wiped out everything from the HD
and reinstalled Debian woody on to the "normal" box (with Maxtor) and
rebuilt the kernel to 2.4.22. This used-to-be normal box started to
generate the i8253 message since then.

Then I downgraded both boxes to kernel 2.4.20. Now both boxes are running
woody and kernel 2.4.20 on identical hardware exept HD's and RAM's. Well,
both boxes completely stop the i8253 message since the OS downgrade :). I
don't have any knowledge regarding the technical details but I think
reporting this "history" to this list should be a good idea.

Best Regards,
CN

-- 
http://www.fastmail.fm - Send your email first class
