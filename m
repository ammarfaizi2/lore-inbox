Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758670AbWK1Nd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758670AbWK1Nd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 08:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758671AbWK1Nd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 08:33:27 -0500
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:56462 "EHLO
	lucian.tromer.org") by vger.kernel.org with ESMTP id S1758670AbWK1Nd0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 08:33:26 -0500
Message-ID: <456C3A54.30702@tromer.org>
Date: Tue, 28 Nov 2006 15:32:04 +0200
From: Eran Tromer <eran@tromer.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061107 Fedora/1.5.0.8-1.fc5 Thunderbird/1.5.0.8 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu> <EB3E5F09-6529-4AB9-B7EF-DFCACC6D445E@mac.com>
In-Reply-To: <EB3E5F09-6529-4AB9-B7EF-DFCACC6D445E@mac.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-27 23:52, Kyle Moffett wrote:
> Actually, our current /dev/random implementation is secure even if the
> cryptographic algorithms can be broken under traditional circumstances. 

This is far from obvious, and in my opinion incorrect. David explained
this very well in his follow-up. Other pertinent references are
Gutterman Pinkas Reinman '06 [1], Barak and Halevi '05 [2, Section 5.1],
and the "/dev/random is probably not" thread [3].

The current algorithm is probably OK for casual users in normal
circumstances, but advertising it as absolutely secure is dangerously
misleading.

  Eran

[1] http://www.gutterman.net/publications/GuttermanPinkasReinman2006.pdf
[2] http://eprint.iacr.org/2005/029
[3] http://www.mail-archive.com/cryptography@metzdowd.com/msg04215.html

