Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbTHSVO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTHSVO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:14:58 -0400
Received: from dialin-212-144-038-053.arcor-ip.net ([212.144.38.53]:13184 "EHLO
	4100xcdt.arbeitsgruppe") by vger.kernel.org with ESMTP
	id S261291AbTHSVLO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:11:14 -0400
Message-ID: <3F415CB8.9080801@SySS.de>
Date: Tue, 19 Aug 2003 01:09:44 +0200
From: Carl-Daniel Hailfinger <hailfinger-lists@syss.de>
Organization: SySS
MIME-Version: 1.0
To: bugtraq@securityfocus.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Advisory] SECURITY BUG in BitKeeper
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

SySS Security Advisory

Date: 2003-07-25 (Published 2003-08-19)

Author: Carl-Daniel Hailfinger <hailfinger-lists@SySS.de>
        SySS GmbH
        72070 Tübingen / Germany
        Phone: +49-7071-407856-0
        http://www.syss.de

Permanent URL: http://www.syss.de/advisories.php?id=7&year=2003

Application: BitKeeper

Affected versions: All versions <3.0.2

Application notes: BitKeeper is an advanced source code control system
like CVS, see http://www.bitkeeper.com

Vendor status: The vendor of BitKeeper is aware of the problem and has
documented it since at least two years. BitMover has been contacted by me
on 2003-07-25.

Type: Configuration error: insecure by default, fix is documented

Description: Certain parts of the trigger functionality in BitKeeper can
be abused by an attacker if a user accepts a patch containing specially
crafted files.

Severity: Critical.

Affected persons: Any user running bitkeeper and accepting patches from
outside of a trusted network - possibly the majority of Linux Kernel
developers.

Additional notes: I have an exploit readily available.

Because of the severity of this issue, BitMover has been contacted and is
working with SySS and the BK users to resolve the issue before exposing
the details of the problem.  There will be a followup security advisory in
2-4 weeks, after people feel that the problem has been contained; the
followup will disclose the details of the problem.

Workaround: If you are worried about it you can add
	export BK_NO_TRIGGERS=YES
to your .profile and the trigger functionality will be disabled.


Regards,
Carl-Daniel

- --
Carl-Daniel Hailfinger
Security Consultant
SySS GmbH
Friedrich-Dannenmann-Str. 2
D-72070 Tuebingen
Phone: +49-7071-407856-0
Mail: hailfinger-lists@syss.de
http://www.syss.de
Key fingerprint: B35E 0E38 9A18 3B25 209F  002E 4743 1599 A495 B6E5

-----BEGIN PGP SIGNATURE-----

iD4DBQE/QVyyR0MVmaSVtuURAq+uAJ0bE5rl7Khcz6R2T+hM8NJH/9fLqACY+J/T
z5E2BbUC9xxR4IR4LdOxcw==
=p2oN
-----END PGP SIGNATURE-----


