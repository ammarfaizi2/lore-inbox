Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317992AbSGLG4o>; Fri, 12 Jul 2002 02:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317987AbSGLG4n>; Fri, 12 Jul 2002 02:56:43 -0400
Received: from khms.westfalen.de ([62.153.201.243]:56288 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S317990AbSGLG4l>; Fri, 12 Jul 2002 02:56:41 -0400
Date: 12 Jul 2002 08:49:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8Skj1EFHw-B@khms.westfalen.de>
In-Reply-To: <20020712035658.83B41412D@lists.samba.org>
Subject: Re: Rusty's module talk at the Kernel Summit
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.GSO.4.21.0207111928390.9488-100000@weyl.math.psu.edu> <20020712035658.83B41412D@lists.samba.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rusty@rustcorp.com.au (Rusty Russell)  wrote on 12.07.02 in <20020712035658.83B41412D@lists.samba.org>:

> As implemented, it results in spurious failure.  Failing to do
> something because the module was being removed at the time, and
> falling back to module load fails because the old module hasn't
> released some resource yet.

Hmm.

Anyone thought about the idea of parking a module in unregistered-but-not- 
removed state, such that it can be "reloaded" by just getting it to  
reregister, and only actually removing it later (from a userspace  
trigger)?

Or would that only move the problem moment?

MfG Kai
