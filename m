Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265807AbUAMW3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUAMW3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:29:18 -0500
Received: from main.gmane.org ([80.91.224.249]:29413 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265807AbUAMW20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:28:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: ide driver from 2.4 to 2.6
Date: Tue, 13 Jan 2004 23:28:23 +0100
Message-ID: <yw1xhdyzcwl4.fsf@kth.se>
References: <1074031396.40046b2428b50@webmail.levangernett.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:0REhA9+JrZy/DBPjQy5ndH7NNGQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

martin@linuxnerds.net writes:

> I have recently purchased the highpoint rocketraid 1540, which comes
> with a driver. It wount compile in 2.6.1,

Use the Linux native driver for hpt374.  It works fine for me with
2.6.0.  I'm running software RAID on four disks with no problems so
far (uptime nearly 6 days, that's when I installed 2.6.0).

> which is understandable. I tried the promise open source driver,
> which results in a similar error, somewhere in the irq- system
> (irq.h).
>
> Now the question is, would it be a accomplishable task for me to fix
> this, and what are the differences from the old to the new one, and
> what must i watch out for?

The Highpoint driver is one of the ugliest pieces of code I've seen.
I'm surprised it works at all.  Don't go near it if you wish to keep
your sanity.

There have been scattered reports of trouble with the hpt374 chip
lately, so maybe I have been lucky.  I'd still suggest that you give
it a try.

-- 
Måns Rullgård
mru@kth.se

