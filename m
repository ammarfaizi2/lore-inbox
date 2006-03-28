Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWC1P5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWC1P5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWC1P5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:57:49 -0500
Received: from smtpout.mac.com ([17.250.248.73]:22503 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932090AbWC1P5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:57:49 -0500
In-Reply-To: <Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr>
References: <200603141619.36609.mmazur@kernel.pl> <20060326065205.d691539c.mrmacman_g4@mac.com> <4426A5BF.2080804@tremplin-utc.net> <200603261609.10992.rob@landley.net> <44271E88.6040101@tremplin-utc.net> <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com> <Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com>
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [OT] Non-GCC compilers used for linux userspace
Date: Tue, 28 Mar 2006 10:57:12 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 28, 2006, at 09:20:09, Jan Engelhardt wrote:
>> Eh, not really.  "__inline__" is GCC-specific and probably won't  
>> work in other compilers (unless you did "#define __inline__",  
>> which would bloat the code a lot).
>
> But ___inline is a C99 keyword, is not it?

Not even GCC fully supports C99 (although I think it does support  
that keyword when passed -std=c99 or -std=gnu99), and I suspect that  
a majority of the other compilers for which we would want to add  
support in the kernel headers would not support C99 or would do a  
poor job of handling inline functions.

But my question still stands.  Does anybody actually use any non-GCC  
compiler for userspace in Linux?

Cheers,
Kyle Moffett


