Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSA2W2d>; Tue, 29 Jan 2002 17:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbSA2W2Y>; Tue, 29 Jan 2002 17:28:24 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:28944 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S284933AbSA2W2P>;
	Tue, 29 Jan 2002 17:28:15 -0500
Date: Tue, 29 Jan 2002 12:36:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: Kim Oldfield <swsusp@oldfield.wattle.id.au>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Swsusp mailing list <swsusp@lister.fornax.hu>
Subject: ext3 & swsusp [was Re: [swsusp] swsusp for 2.4.17 -- newer ide supported]
Message-ID: <20020129113625.GD241@elf.ucw.cz>
In-Reply-To: <20020128100704.GA3013@elf.ucw.cz> <20020128230132.GB24550@barclay.its.monash.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020128230132.GB24550@barclay.its.monash.edu.au>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> ] This is newer version of swsusp patch. It now supports newer ide
> ] driver (which just about everybody uses). It sometimes fails to
> ] suspend when top is running, otherwise no bugs are known. Try to break
> ] this one!
> 
> (As with previous versions) it does not work with ext3:
> 
> Cut and paste from syslog:
> twilight kernel: SysRq : Software suspend
> twilight kernel: 
> twilight kernel: Suspend Machine: Stopping processes
> twilight kernel: Suspend Machine: Waiting for tasks to stop... ::::::::::::::::::::::::::::
> twilight kernel:  stopping tasks failed (1 tasks remaining)
> twilight kernel: Suspend Machine: Not all processes stopped!
> twilight kernel: Resume Machine: Restarting tasks...<6> Strange, kjournald not stopped
> twilight kernel:  done
> twilight kernel: Resume Machine: Done resume from 0

Yup, known, and I even had patch for this from someone from
swsusp mailing list. Could that preson please mail it to me once
again?
								Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
