Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272441AbRILVqE>; Wed, 12 Sep 2001 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272322AbRILVp4>; Wed, 12 Sep 2001 17:45:56 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:25860 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S271795AbRILVpc>;
	Wed, 12 Sep 2001 17:45:32 -0400
Message-ID: <20010911005318.C822@bug.ucw.cz>
Date: Tue, 11 Sep 2001 00:53:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: vojtech@ucw.cz, Hamera Erik <HAMERAE@cs.felk.cvut.cz>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010909170206.A3245@redhat.com> <20010909230920.A23392@atrey.karlin.mff.cuni.cz> <9nh5p0$3qt$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <9nh5p0$3qt$1@cesium.transmeta.com>; from H. Peter Anvin on Sun, Sep 09, 2001 at 06:41:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > RPLD implements the IBM RIPL protocol, used to network boot some
> > machines. It DOES NOT implement the Novell style RPL/IPX protocol.
> > If your are not sure which protocol you are using see the section
> > "Troubleshooting".
> > 
> > And, indeed, it does not work with Novell bootrom. If you have
> > different version, please let me know...
> > 
> 
> If someone has specs for these things I might give implementing it a
> shot.

I found out I can boot it after little games with mars netware
emulator. However I have problems booting anything else than
freedos. Trying to boot zImage directly results in crc errors or in
errors in compressed data. Too much failures and too repeatable
(althrough ram seems flakey) for me to believe its hw.
								Pavel 
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
