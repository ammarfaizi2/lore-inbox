Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132789AbRASQdd>; Fri, 19 Jan 2001 11:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135347AbRASQdZ>; Fri, 19 Jan 2001 11:33:25 -0500
Received: from ns.sysgo.de ([213.68.67.98]:49147 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S132789AbRASQdK>;
	Fri, 19 Jan 2001 11:33:10 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: Steve Hill <steve@navaho.co.uk>
Subject: Re: 2.4 on Cobalt hardware 
Date: Fri, 19 Jan 2001 17:20:00 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.21.0101191436190.2810-100000@sorbus.navaho>
In-Reply-To: <Pine.LNX.4.21.0101191436190.2810-100000@sorbus.navaho>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01011917330400.02042@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fre, 19 Jan 2001 you wrote:
> On Fri, 19 Jan 2001, RobertKaiser wrote:
> 
> > On Thu Jan 18 16:30:30 2001 steve@navaho.co.uk wrote
> > > Has anyone had any luck getting a 2.4 kernel to run on Cobalt x86
> > > hardware?  It doesn't even seem to start (I get nothing on the screen from
> > >t he kernel, it just sits there and does nothing). :(
> > 
> > What processor does it use ? (386 or 486 perchance?)
> 
> AMD K6 (so 586) - I was trying the i386 version of the kernel on it
> though, if that's going to be a problem, I can try the 586 version...

I was asking because the 2.4.0 kernel has a bug that causes it to fail on
386 and 486 CPUs with the same symptoms as you described. I don't know
much about the K6, so I can't tell whether it will fall into the same trap (I
guess it won't).

Nevertheless, if you want to be sure, try the latest (pre8) patch from

  ftp://ftp.kernel.org/pub/linux/kernel/testing/

that particular bug has been fixed in that version.

Good Luck

Rob

----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
