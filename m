Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRISKUU>; Wed, 19 Sep 2001 06:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274029AbRISKUJ>; Wed, 19 Sep 2001 06:20:09 -0400
Received: from ns.suse.de ([213.95.15.193]:19475 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S268133AbRISKUB> convert rfc822-to-8bit;
	Wed, 19 Sep 2001 06:20:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Forced umount (was lazy umount)
In-Reply-To: <fa.d1dh3vv.fmmj8f@ifi.uio.no> <fa.e30ljmv.19jambt@ifi.uio.no>
	<0a0c01c140a8$92b45620$1a01a8c0@allyourbase>
	<20010918181939.D10602@mikef-linux.matchmail.com>
X-Yow: -- I can do ANYTHING ... I can even ... SHOPLIFT!!
From: Andreas Schwab <schwab@suse.de>
Date: 19 Sep 2001 12:20:24 +0200
In-Reply-To: <20010918181939.D10602@mikef-linux.matchmail.com> (Mike Fedyk's message of "Tue, 18 Sep 2001 18:19:39 -0700")
Message-ID: <jevgifo51z.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.106
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

|> On Tue, Sep 18, 2001 at 09:15:24PM -0400, Dan Maas wrote:
|> > > Imagine (common error for me):
|> > >
|> > > cd /cdrom
|> > > kwintv &
|> > > [work]
|> > >
|> > > I now want to umount cdrom. How do I do it? Do you suggest each app
|> > > to have "cd /" menu entry?
|> > > Pavel
|> > 
|> > No but now that you mention it, it might be a good idea for GUI programs to
|> > chdir("/") by default immediately on startup. (and fork/daemonize so they
|> > don't disappear if you accidentally close the xterms you used to start them)
|> > 
|> 
|> Just disown it after you bg it ie:
|> 
|> xmms & disown

This is not necessary unless you did 'shopt -s huponexit'.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
