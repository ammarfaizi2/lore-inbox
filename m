Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRJaVdn>; Wed, 31 Oct 2001 16:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRJaVdd>; Wed, 31 Oct 2001 16:33:33 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:57083 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S273213AbRJaVd0>; Wed, 31 Oct 2001 16:33:26 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D6DC@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Alex Bligh - linux-kernel'" <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: RE: 2xQ: Is PM + ACPI but /no/ APM a valid configuration? Interru
		pts enabled in APM set power state?
Date: Wed, 31 Oct 2001 13:33:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not enabling the busmgr and EC is a not particularly useful config at this
point, but the option is available for debugging reasons, and also it
enables us to determine acpi's core interpreter size more easily.

If you are willing to try acpi, I'd recommend everything on for now.

Regards -- Andy

> -----Original Message-----
> From: Alex Bligh - linux-kernel [mailto:linux-kernel@alex.org.uk]
> Sent: Wednesday, October 31, 2001 1:02 PM
> To: Alex Bligh - linux-kernel; Grover, Andrew;
> linux-kernel@vger.kernel.org
> Cc: Alex Bligh - linux-kernel
> Subject: RE: 2xQ: Is PM + ACPI but /no/ APM a valid configuration?
> Interru pts enabled in APM set power state?
> Importance: High
> 
> 
> > For the hard of understanding, such as myself, do you mean the
> > ACPI bus manager (CONFIG_ACPI_BUSMGR)? I had that unset, on
> > the basis of least change, but can try it, or did you mean
> > something else?
> 
> This was a stupid question derived from being up too many
> hours. Andrew obviously meant 'embedded controller', the config
> option for which depends on bus manager being selected
> too. Apols.
> 
> Is selecting ACPI without these an invalid config? Or just
> on my laptop?
> 
> --
> Alex Bligh
> 
