Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135359AbRAYRwk>; Thu, 25 Jan 2001 12:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132027AbRAYRwD>; Thu, 25 Jan 2001 12:52:03 -0500
Received: from office.globe.cz ([212.27.204.26]:25098 "HELO gw.office.globe.cz")
	by vger.kernel.org with SMTP id <S132577AbRAYRvp>;
	Thu, 25 Jan 2001 12:51:45 -0500
Received: from ondrej.office.globe.cz (10.1.2.22)
  by vger.kernel.org with SMTP; 25 Jan 2001 17:51:39 -0000
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre10 slowdown at boot.
In-Reply-To: <118870000.980442428@tiny>
From: Ondrej Sury <ondrej@globe.cz>
Date: 25 Jan 2001 18:51:33 +0100
In-Reply-To: <118870000.980442428@tiny>
Message-ID: <87d7dby0yi.fsf@ondrej.office.globe.cz>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Chris Mason <mason@suse.com> writes:

> On Thursday, January 25, 2001 05:23:26 PM +0100 Ondrej Sury
> <ondrej@globe.cz> wrote:
>=20
> >=20
> > 2.4.1-pre10 slows down after printing those (maybe ACPI or reiserfs
> > issue), and even SysRQ-(s,u,b) is not imediate and waits several (two+)
> > seconds before (syncing,remounting,booting).
> >=20
> > ACPI: System description tables found
> > ACPI: System description tables loaded
> > ACPI: Subsystem enabled
> > ACPI: System firmware supports: C2
> > ACPI: System firmware supports: S0 S1 S4 S5
> > reiserfs: checking transaction log (device 03:04) ...
> > Warning, log replay starting on readonly filesystem
> >=20
>=20
> Here, reiserfs is telling you that it has started replaying transactions =
in
> the log.  You should also have a reiserfs message telling you how many
> transactions it replayed, and how long it took.  Do you have that message?

Nope.  I rebooted with Alt-SysRQ+B after some while (aprox more than 30
sec, normally reiserfs replay is taking ~5 sec (pre9)).  I wasn't so
patient.  I could test it before I'll go from work to home.

=2D-=20
Ond=F8ej Sur=FD <ondrej@globe.cz>         Globe Internet s.r.o. http://glob=
e.cz/
Tel: +420235365000   Fax: +420235365009         Pl=E1ni=E8kova 1, 162 00 Pr=
aha 6
Mob: +420605204544   ICQ: 24944126             Mapa: http://globe.namape.cz/
GPG fingerprint:          CC91 8F02 8CDE 911A 933F  AE52 F4E6 6A7C C20D F273
--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.5 and Gnu Privacy Guard <http://www.gnupg.org/>

iEYEARECAAYFAjpwZ6UACgkQ9OZqfMIN8nNX0QCgo57SEoNlC+BUmt/jbnBXEQY6
BiEAn1g9tqG5p8O4iJm3boqysKTiMj4u
=8aS9
-----END PGP MESSAGE-----
--=-=-=--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
