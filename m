Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313758AbSDHV1h>; Mon, 8 Apr 2002 17:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313759AbSDHV1g>; Mon, 8 Apr 2002 17:27:36 -0400
Received: from gw.wmich.edu ([141.218.1.100]:11752 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S313758AbSDHV1g>;
	Mon, 8 Apr 2002 17:27:36 -0400
Subject: Re: Make swsusp actually work
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: brian@worldcontrol.com
Cc: Pavel Machek <pavel@ucw.cz>, alan@redhat.com,
        kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020408211558.GA1864@top.worldcontrol.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 Apr 2002 17:27:26 -0400
Message-Id: <1018301252.485.0.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-08 at 17:15, brian@worldcontrol.com wrote:
> On Mon, Apr 08, 2002 at 01:37:26AM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > There were two bugs, and linux/mm.h one took me *very* long to
> > find... Well, those bits used for zone should have been marked. Plus I
> > hack ide_..._suspend code not to panic, and it now seems to
> > work. [Sorry, 2pm, have to get some sleep.]
> 
> I've applied both this patch and the earlier one, and now my
> 2.4.19-pre5-ac3 system can suspend and it can resume.  However,
> when it resumed, I was stuck in the kernel SysRq function.
> 
> Couldn't get out of it.

press alt Sysrq again and then enter

> And nothing seemed to work, other than it kept displaying the
> help each time I touched a key.
> 
> On the other hand, the swsusp in 2.4.18-WOLK3.3 works correctly.
> 


