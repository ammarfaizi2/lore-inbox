Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130004AbRCAUfL>; Thu, 1 Mar 2001 15:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129935AbRCAUdr>; Thu, 1 Mar 2001 15:33:47 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129915AbRCAUaz>;
	Thu, 1 Mar 2001 15:30:55 -0500
Message-ID: <20010301003347.B1319@bug.ucw.cz>
Date: Thu, 1 Mar 2001 00:33:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Manfred H. Winter" <mahowi@gmx.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.2-ac5] X (4.0.1) crashes
In-Reply-To: <20010227150830.A739@marvin.mahowi.de> <E14XuXd-0004bA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E14XuXd-0004bA-00@the-village.bc.nu>; from Alan Cox on Wed, Feb 28, 2001 at 12:32:26AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I use XFree86 4.0.1 with nvidia-drivers 0.96.
> 
> Take it up with nvidia. Obfuscated effectively binary only code isnt anyone
> elses problem

Is it legal, BTW? Obfuscated drivers should _not_ be linked into
kernel, because they are not "form preferable for editing". 

<GPL>
The source code for a work means the preferred form of the work for
making modifications to it.  For an executable work, complete source
</GPL>

So nvidia drivers *are* binary only, as far as GPL is concerned. They
should never be linked into kernel.

[Or, someone should get kernel with nvidia drivers compiled in from
nvidia, and then ask them for sources :-)]
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
