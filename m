Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263092AbTCSPxm>; Wed, 19 Mar 2003 10:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263093AbTCSPxm>; Wed, 19 Mar 2003 10:53:42 -0500
Received: from pdbn-d9bb871b.pool.mediaWays.net ([217.187.135.27]:11014 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S263092AbTCSPxl>;
	Wed, 19 Mar 2003 10:53:41 -0500
Date: Wed, 19 Mar 2003 17:04:37 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: "Richard B. Johnson" <johnson@quark.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Everything gone!
Message-ID: <20030319160437.GA22939@citd.de>
References: <Pine.LNX.4.53.0303191041370.27397@quark.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0303191041370.27397@quark.analogic.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 10:46:11AM -0500, Richard B. Johnson wrote:
> Hello.
> I log to new account of RedHat 8.0 and do
> cd /
> for x in `find . -name "*"` ; do /bin/rm $x; done
> See I am UNIX Expert NO?
> 
> After, I cant log in?
> How do get back all after /?

Hmmm.
rm -rf *
Should do the same(*) but with much better speed.

Normaly the system should lockup at sometime while doing it.




*: OK. The version above will "break" in the middle after "/bin/rm" (or
"/lib/libc.so.6") got deleted.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

