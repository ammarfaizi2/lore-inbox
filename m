Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVCWSnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVCWSnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 13:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVCWSnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 13:43:05 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:50191 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261595AbVCWSms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 13:42:48 -0500
Message-ID: <4241B8C8.2020805@tuleriit.ee>
Date: Wed, 23 Mar 2005 20:43:20 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 1.0 (X11/20050215)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA bugs in list [was Re: 2.6.12-rc1-mm1]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Lee Revell <rlrevell@xxxxxxxxxxx> wrote:
 > >
 > > On Mon, 2005-03-21 at 12:41 -0800, Andrew Morton wrote:
 > > > From: bugme-daemon@xxxxxxxx
 > > > Subject: [Bug 4282] ALSA driver in Linux 2.6.11 causes a kernel 
panic when
 > > > loading the EMU10K1 driver
 > > >
 > > >
 > > This one is a real mystery. No one can reproduce it.

 > Not quite true. This bug was current till today in Mandrake's kernel,
 > but with 2.6.11-5mdk they managed to get rid of it.
 > The problem is not with loading the driver but when alsactl tries to 
store/restore
 > mixer settings.

 > I have tried again with 2.6.12-rc1-mm1 and it is still there (for 
example the
 > Gnome won't start due to this).
 > Below the oops part from messages.

uhh...sorry about that noise. I misread your e-mail.


 > >/ From: bugme-daemon@xxxxxxxx/
 > >/ Subject: [Bugme-new] [Bug 4348] New: snd_emu10k1 oops'es with 
Audigy 2 and/
 > >/ /
 >
 > This one is fixed in ALSA CVS. Here is the patch.


I had this problem indeed and of course this patch fixed 2.6.12-rc1-mm1 
for me.

Thank you and sorry again,
Indrek

