Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUADCvc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 21:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUADCvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 21:51:31 -0500
Received: from smtp3.att.ne.jp ([165.76.15.139]:28328 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S264925AbUADCva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 21:51:30 -0500
Message-ID: <014a01c3d26d$9c24ee00$74ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Wrapping jiffies [was Re: udev and devfs - The final word]
Date: Sun, 4 Jan 2004 11:50:45 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> BTW, as we are currently in stable series, it might be good idea to
> make jiffies start at zero...

I disagree.  The importance of fixing bugs does not decrease in stable.
Hiding bugs is still the opposite of fixing bugs.

Perhaps I misunderstand the meaning of stable, but I expected stable to mean
that efforts tend more towards fixing things so they work properly, and
unstable meant that efforts tend more towards adding features even though
they're broken at first.  Hiding a broken thing is still the opposite of
fixing a broken thing.

> Hopefully jiffie wrap had enough testing during stable...

I think you mean unstable, in which case I agree with this half of what I
think you meant.  This still doesn't give any reason to switch back to
hiding things.  In fact this doesn't give any reason to switch from a
technique that "hopefully [...] had enough testing" to a different
technique, even if logically the different technique doesn't need as much
testing.

