Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLOKxf>; Fri, 15 Dec 2000 05:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOKx0>; Fri, 15 Dec 2000 05:53:26 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4612 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129953AbQLOKxM>;
	Fri, 15 Dec 2000 05:53:12 -0500
Message-ID: <20001215003405.A190@bug.ucw.cz>
Date: Fri, 15 Dec 2000 00:34:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Shutko <ats@acm.org>, James Simmons <jsimmons@suse.com>
Cc: Pavel Machek <pavel@suse.cz>,
        Frédéric L . W . Meunier 
	<0@pervalidus.net>,
        linux-kernel@vger.kernel.org
Subject: Re: SysRq behavior
In-Reply-To: <Pine.LNX.4.21.0012111440460.296-100000@euclid.oak.suse.com> <871yve4i77.fsf@wesley.springies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <871yve4i77.fsf@wesley.springies.com>; from Alan Shutko on Mon, Dec 11, 2000 at 07:05:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Just played with this bug. It doesn't kill a login shell but does any
> > app running on it. I just went looking for where "Quit" is printed
> > out. When I press SysRq Quit is printed on the command line. Any ideas?
> 
> Not a bug.  Normally,. PrtSc will generate a ^\, which is the default
> value of stty quit.  Try
> 
> stty quit ^A
> cat
> 
> and hit PrtSc

Okay, perhaps then it is bad for PrtSc to generate such dangerous
combination by default. Still bug ;-).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
