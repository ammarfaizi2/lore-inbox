Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264844AbTFERY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbTFERY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:24:26 -0400
Received: from ppp-62-245-208-76.mnet-online.de ([62.245.208.76]:50079 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S264844AbTFERYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:24:25 -0400
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: capacity in 2.5.70-mm3
From: Julien Oster <lkml@mf.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Thu, 05 Jun 2003 19:37:57 +0200
In-Reply-To: <20030603192010$790e@gated-at.bofh.it> (Felipe Alfaro Solana's
 message of "Tue, 03 Jun 2003 21:20:10 +0200")
Message-ID: <frodoid.frodo.87y90g8lxm.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <20030603181011$5b1a@gated-at.bofh.it>
	<20030603192010$790e@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:

Hello,

>> capacity  capacity  capacity  driver  identify  media  model  settings
>> Multiplay capacity files. Funny :)

> Can reproduce it on my laptop with 2.5.70-mm3 and my server with
> 2.5.70-bk8. Both have an ATAPI DVD attached to /dev/hdc.

Can also reproduce it on 2.4.21-rc1, on all my IDE devices: hda, hdc,
hdg. The first two are harddrives, the last one's an ATAPI CD writer,
so the device type doesn't seem to matter:

/proc/ide# ls hd?
hda:
cache     capacity  geometry  media  settings          smart_values
capacity  driver    identify  model  smart_thresholds

hdc:
cache     capacity  geometry  media  settings          smart_values
capacity  driver    identify  model  smart_thresholds

hdg:
capacity  capacity  driver  identify  media  model  settings

Julien
