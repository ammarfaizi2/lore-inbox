Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUBVXmV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 18:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbUBVXmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 18:42:21 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:14284 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261244AbUBVXmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 18:42:19 -0500
To: david+challenge-response@blue-labs.org
Subject: Re: SONY SMO-F551, non-functional for a loong time :)
X-Newsgroups: chiark.mail.linux-rutgers.kernel
In-Reply-To: <403939D4.9020804@blue-labs.org>
Organization: Invalid argument
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1Av3Ek-0000G2-00@sledge.mossbank.org.uk>
From: Steve McIntyre <steve@einval.com>
Date: Sun, 22 Feb 2004 23:42:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford writes:
>For the last couple of years, this MO drive (I have several) has been 
>unusable.  It used to lock up the machine if I had a disc inside it when 
>I booted, but that was late in 2.5, and now with 2.6.3, it no longer 
>hangs the machine, however, it's still not usable.
>
>I'd love to get this bugger working, I used to use it a long long time 
>ago in 2.4 kernels.  Any suggestions?

You've got hardware problems, either media or drive:

>sda: Unit Not Ready, sense:
>Current : sense key Hardware Error
>ASC=40 ASCQ=86

Key/code/qual 4/40/86 is (IIRC) Read Channel Calibration Failure,
which means either the drive hardware is failing or (more likely) the
disk loaded is buggered and the drive can't read it any more. Try
another disk...

-- 
Steve McIntyre, Cambridge, UK.                                steve@einval.com
"I've only once written 'SQL is my bitch' in a comment. But that code 
 is in use on a military site..." -- Simon Booth
