Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271869AbRHUVu6>; Tue, 21 Aug 2001 17:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271871AbRHUVui>; Tue, 21 Aug 2001 17:50:38 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:33527 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S271870AbRHUVuf>;
	Tue, 21 Aug 2001 17:50:35 -0400
Message-ID: <3B82D7B6.F79819B7@gmx.at>
Date: Tue, 21 Aug 2001 23:50:46 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 [I] just run xdos
In-Reply-To: <Pine.LNX.4.33.0108191600580.10914-100000@boston.corp.fedex.com>
			<m166bjokre.fsf@frodo.biederman.org>
			<20010819214322.D1315@squish.home.loc>
			<m1snenmfe0.fsf@frodo.biederman.org>
			<20010820211410.B218@squish.home.loc>
			<m1g0amlzcm.fsf@frodo.biederman.org> <3B828898.BD98D4C4@gmx.at> <m1ae0tmll8.fsf@frodo.biederman.org> <3B82AD39.1268A6F0@gmx.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilfried Weissmann wrote:
> 
> "Eric W. Biederman" wrote:
> >
> > Wilfried Weissmann <Wilfried.Weissmann@gmx.at> writes:
> > >
> > > I have the same problem on a K7-800. My kernel is 2.4.7-ac3 (with K7
> > > optimization!). Everything else seems to work fine, but dosemu locks up
> > > the computer when running certain games.
> > > Sometimes I can play for quite some time (1/2 hour or more) without
> > > problems. Eventually it will freeze. It feels like it is triggered by
> > > mouse activity.
> >
> > Hmm.  There are some similiar conditions.  And it may be the same bug.
> >
> > Is your dosemu not suid root?  And running in X when you are playing those
> > games?  You don't have any ports lines in your dosemu.conf?
> >
> > It is very important to rule out dosemu doing direct hardware access, before investigating
> > something else like the kernel.
> 
> I set $_videoportaccess = (0)
> This should not change anything since $_graphics=(0) too. However I
> experienced no more crashes. (???)

argh! I take it back. It just crashed again. There are no port entries
and the setuid bit of the executable is not set.
It is quite hard to reproduce. ... takes some hours of intense testing
;)

Wilfried
