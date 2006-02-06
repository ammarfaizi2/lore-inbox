Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWBFU3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWBFU3O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWBFU3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:29:13 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:29345 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964783AbWBFU3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:29:11 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 7 Feb 2006 06:25:45 +1000
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, Rafael Wysocki <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602061543.42174.nigel@suspend2.net> <1139251682.2791.290.camel@mindpipe>
In-Reply-To: <1139251682.2791.290.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2320407.F5f14S2HAN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602070625.49479.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2320407.F5f14S2HAN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 07 February 2006 04:48, Lee Revell wrote:
> On Mon, 2006-02-06 at 15:43 +1000, Nigel Cunningham wrote:
> > Hi.
> >
> > On Monday 06 February 2006 14:34, Lee Revell wrote:
> > > On Mon, 2006-02-06 at 14:02 +1000, Nigel Cunningham wrote:
> > > > (they now have to download extra
> > > > libraries to use the splashscreen, which were not required with
> > > > the bootsplash patch, and need to check whether an update to the
> > > > userui code
> > > > is required when updating the kernel)
> > >
> > > You could have avoided this problem by keeping the
> > > userspace<->kernel interface stable.
> >
> > True, but sometimes you need to make changes that do modify the
> > interface. If the interface involves more functionality, this will
> > happen more frequently.
>
> Well, all I can say is, it should have been obvious that putting a
> themeable UI in the kernel would not fly.

Agreed, but I think we have some confusion here.

I was talking about interactions between kernel space and userspace after=20
we started using the userspace interface. In particular, I was thinking of=
=20
the fact that the netlink message number kept changing due to changes in=20
the vanilla kernel. In the end, we just made it a command line option to=20
the userui.

My point for this conversation was different, though. If uswsusp ever does=
=20
fly, there are going to be flag days where users are going to have to=20
download new userspace code, perhaps new versions of libraries or new=20
libraries, run the compilation and reconfigure their initrds/ram-fses, all=
=20
just because they upgraded their kernel and want to continue to suspend to=
=20
disk. That is extra complexity introduced by using a userspace 'brain'=20
instead of having it in kernelspace.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2320407.F5f14S2HAN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD57DNN0y+n1M3mo0RAvOdAKDGuXn30lQnnN0BI13vNRM4E/LScQCfX7uf
njU220K7jrglbDUfTJw3vps=
=zGI+
-----END PGP SIGNATURE-----

--nextPart2320407.F5f14S2HAN--
