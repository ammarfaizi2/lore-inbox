Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVBHVoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVBHVoc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 16:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVBHVoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 16:44:32 -0500
Received: from mx1.elte.hu ([157.181.1.137]:19927 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261662AbVBHVo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 16:44:27 -0500
Date: Tue, 8 Feb 2005 22:44:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and UML?
Message-ID: <20050208214411.GA22960@elte.hu>
References: <200502081855.j18ItFs0012685@ccure.user-mode-linux.org> <Pine.OSF.4.05.10502082009360.23457-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10502082009360.23457-100000@da410.phys.au.dk>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Now I don't really know who I am responding to. But both up()s now
> changed to complete()s are in something looking very much like an
> interrupt handler. But again, as I said, I didn't analyze the code in
> detail, I just made it compile and checked that it worked in bare
> 2.6.11-rc2 UML - which I am not too sure how to set up and use to
> begin with!

btw., UML is really easy to begin with: after you've compiled you get a
'linux' binary in the toplevel directory - just execute it via './linux'
and you'll see a Linux kernel booting - that's all you need!

Add a filesystem image via a root= parameter to that command and the UML
kernel will start booting that filesystem image. (if you are adventurous
you can even boot a real partition, but for the first user this is
strongly discouraged.) There are a number of UML-ready filesystem images
downloadable from the net.

	Ingo
