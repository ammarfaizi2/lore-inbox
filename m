Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbTLZRxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 12:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbTLZRxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 12:53:46 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:9663 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S265205AbTLZRxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 12:53:45 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: Oopses on 2.6.0
Date: Fri, 26 Dec 2003 18:53:00 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2003.12.26.17.52.57.987898@smurf.noris.de>
References: <20031226173134.GA14038@home.woodlands>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1072461180 1786 192.109.102.39 (26 Dec 2003 17:53:00 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 26 Dec 2003 17:53:00 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Apurva Mehta wrote:

>    2) More regularly (almost every day), applications like gkrellm, xmms
>    and xemacs crash. When I try to restart them, I get a segmentation
>    fault. The only way to restart them is to reboot the computer. Xemacs
>    starts on the console. Again, the logs do not have any info (both the
>    kernel log and the XFree86 log).

Try -mm1. I had these problems all through 2.6-test, and 2.6.0, but they
seem to have vanished with -mm1.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The trouble with the average family budget is that at the end of the money
there's too much month left.

