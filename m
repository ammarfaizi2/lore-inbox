Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWCWTfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWCWTfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWCWTfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:35:43 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:6079 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751485AbWCWTfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:35:43 -0500
Message-Id: <5.1.0.14.2.20060323203051.025cd200@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 23 Mar 2006 20:36:03 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margitsw@t-online.de>
Subject: Re: unresolved emu10k1 synth symbols.
Cc: davej@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-ID: Xdf7CEZ68eCZAAtSQQllQxgyuNIENSOUCHX9VBxvGT4MvywZwok7gk
X-TOI-MSGID: cc172ba7-f35a-4860-b193-9f72befcd729
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >> with the following modprobe.conf fragment
 >> install snd-emu10k1 /sbin/modprobe --ignore-install snd-emu10k1 && 
/sbin/modprobe snd-emu10k1-synth

Isn't that command wrong ?
You are telling it to ignore the install for snd-emu10k1.
How about :
install snd-emu10k1-synth /sbin/modprobe snd-emu10k1 && /sbin/modprobe 
--ignore-install snd-emu10k1-synth

Margit


