Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSFDSSG>; Tue, 4 Jun 2002 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSFDSSF>; Tue, 4 Jun 2002 14:18:05 -0400
Received: from codepoet.org ([166.70.14.212]:47771 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315374AbSFDSSE>;
	Tue, 4 Jun 2002 14:18:04 -0400
Date: Tue, 4 Jun 2002 12:18:02 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Ian Soboroff <ian.soboroff@nist.gov>, linux-kernel@vger.kernel.org
Subject: Re: Patch for broken Dell C600 and I5000
Message-ID: <20020604181801.GA6419@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Ian Soboroff <ian.soboroff@nist.gov>, linux-kernel@vger.kernel.org
In-Reply-To: <20020604010756.A32059@devserv.devel.redhat.com> <mailman.1023209101.6092.linux-kernel2news@redhat.com> <200206041752.g54HqlW04012@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jun 04, 2002 at 01:52:47PM -0400, Pete Zaitcev wrote:
> You can test your C600 with A17 by doing this. Apply the patch
> (this removes the old workaround), build, reboot. Without
> explicit parameter the new workaround is not activated.

I have a Dell Latitude C800 -- I'll give your patch a try later
today.

On a related note...  I recently updated to Bios A20 and I find
the fan stays on after resuming...  Also, in order for resume to
complete sucessfully I find I need to never start X with dri so
that agp support and the r128 module are not loaded.  If they
load then the laptop hangs when doing a resume.  Known problems?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
