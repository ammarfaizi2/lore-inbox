Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpPizqoA4jaf/S8uPls5wkAc0Vw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Tue, 06 Jan 2004 03:19:11 +0000
Message-ID: <046801c415a4$f8b33350$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:46:16 +0100
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: <Administrator@smtp.paston.co.uk>
Cc: "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Bugfix] Set more than 32K pid_max (reformatted)
In-Reply-To: <Pine.LNX.4.44.0401061042580.26260-100000@mazda.sh.intel.com>
References: <Pine.LNX.4.44.0401061042580.26260-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:46:17.0078 (UTC) FILETIME=[F9129160:01C415A4]

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 6 Jan 2004, Zhu, Yi wrote:

>         if (!offset || !atomic_read(&map->nr_free)) {
> +               if (!offser)

I suppose it should be "if (!offset)"...

Mind Booster Noori

- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQE/+igomNlq8m+oD34RAgGcAJ9p12OYiL/XKCJu4JPczbNO8+P6rwCg3Wdz
eIkeuX3q4JuVHaLeGXGIDIA=
=vP/K
-----END PGP SIGNATURE-----

