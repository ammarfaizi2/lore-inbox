Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVFUSRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVFUSRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVFUSRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:17:23 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:36769 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262164AbVFUSRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:17:16 -0400
Message-Id: <200506211816.j5LIGj3E020507@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adam Goode <adam@evdebs.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Pavel Machek <pavel@suse.cz>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: IBM HDAPS Someone interested? 
In-Reply-To: Your message of "Tue, 21 Jun 2005 11:37:38 EDT."
             <1119368259.19357.18.camel@mindpipe> 
From: Valdis.Kletnieks@vt.edu
References: <20050620155720.GA22535@ucw.cz> <005401c575b3_5f5bba90_600cc60a@amer.sykes.com> <20050620163456.GA24111@ucw.cz> <20050620165703.GB477@openzaurus.ucw.cz> <20050620204533.GA9520@ucw.cz> <1119303016.5194.24.camel@lynx.auton.cs.cmu.edu>
            <1119368259.19357.18.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119377804_10696P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Jun 2005 14:16:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119377804_10696P
Content-Type: text/plain; charset=us-ascii

On Tue, 21 Jun 2005 11:37:38 EDT, Lee Revell said:
> On Mon, 2005-06-20 at 17:30 -0400, Adam Goode wrote:
> > Freefall detection: 300 ms
> > Head park time: 300-500 ms

> Ugh, if userspace can't meet a 300ms RT constraint, that's a pretty
> shitty OS you have there.

Actually, it's a lot tighter than that.  You need to *issue* the "park head"
command 300-500ms before it hits the ground, and you have 300ms of free fall.

So you may have needed to detect the free fall and issue the command 200ms
before the free fall commences.

That's a *real* hard RT constraint to keep. ;)

--==_Exmh_1119377804_10696P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCuFmMcC3lWbTT17ARAk7BAKDruLOrxVmcEgT+fAKp3VUvPdNv9gCfbsG1
uVOULLITkTHQGhQIPg7ZhiY=
=9uBu
-----END PGP SIGNATURE-----

--==_Exmh_1119377804_10696P--
