Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbTAUWqT>; Tue, 21 Jan 2003 17:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267188AbTAUWqT>; Tue, 21 Jan 2003 17:46:19 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:17378 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267084AbTAUWqR>; Tue, 21 Jan 2003 17:46:17 -0500
Date: Tue, 21 Jan 2003 23:55:20 +0100
From: Martin Waitz <tali@admingilde.org>
To: linux-kernel@vger.kernel.org
Subject: Resource Container implementation for Linux
Message-ID: <20030121225520.GA1471@admingilde.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi :)

i'm writing a diploma thesis about using resource containers
for energy accounting, implemented for linux.
(of course, it's possible to use that system for other resources
like cpu-time, too)

the thesis is almost finished (due jan, 31.), but i'm not a native
english speaker and would like to have one review it for me.

the preliminary abstract of the work is quoted below.
if you're interested in reading the complete thesis,
please contact me off-list.
you have to just tell me where i've misused some words, phrases, etc.

code is gpl, of course, and i will make a separate announcement
once i've cleaned it up a bit (but repository is already online).
if there is general interest, i should have some nice patches ready
once 2.7 starts... ;)


---------------------------------------------------------------------
|
|	Accounting and controlling power consumption
|	in energy aware operating systems
|

An important task of operating systems is to fairly schedule shared
resources between several parties.  Precise accounting of consumed
resources is the key to that goal.  However, most operating systems only
use very basic accounting strategies.

This thesis discusses methods for resource accounting and introduces a
powerful, yet easy to use accounting model based on resource containers.
The goal of this model is to always charge the party that is responsible
for some resource usage. To achive this, client-server relationships
between running processes are detected.  They provide an invaluable
source of information which can be used to identify the entities
initiating resource intensive actions.  As the resource containers which
are used for accounting can be nested to form a hierarchy, sophisticated
accounting and scheduling policies can be formulated.

Utilizing this new accounting model, the energy consumption of the
machine can be charged to the individual entity responsible.  Accounting
energy consumption is a very natural way, as every hardware component
that contributes to the execution of a program is consuming energy.
Several methods used to messure or estimate the energy consumption of
various hardware parts are discussed, paying special attention to the
main processor.

Especially peak energy consumption is important as many components have
to be dimensioned according to the maximum power consumption.  Reducing
this peak consumption can save costs in both high-end data centers and
small mobile devices.  A software method for limiting energy consumption
is introduced.  By using the new resource model, advanced policies can
be defined that allow to control power consumption of the entire
machine, individual processes or special clients and servers.



--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.            Benjamin Franklin (1706 - 1790)

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQE+Lc/Xj/Eaxd/oD7IRAgPoAJQLVpkFib5BorF0P5r+E3I0p/xTAJ95psAs
NYYIziRlOHqir+EK6vGWyg==
=1wUk
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
