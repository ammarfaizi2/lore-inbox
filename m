Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpPiI0oxcpm3bT6G30VdSBI6Hhw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Tue, 06 Jan 2004 03:35:30 +0000
Message-ID: <046301c415a4$f8882bb0$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:46:16 +0100
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: <Administrator@smtp.paston.co.uk>
Cc: "Zhu, Yi" <yi.zhu@intel.com>, "Andrew Morton" <akpm@osdl.org>,
        "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [Bugfix] Set more than 32K pid_max (reformatted)
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840254C8C3@PDSMSX403.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="ISO-8859-1"
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:46:17.0078 (UTC) FILETIME=[F9129160:01C415A4]
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.osdl.org id i2TGQw204322

On Tue, 6 Jan 2004, Marcos D. Marado Torres wrote:

> >         if (!offset || !atomic_read(&map->nr_free)) {
> > +               if (!offser)
> 
> I suppose it should be "if (!offset)"...

Yes, my mistake. Thanks!

