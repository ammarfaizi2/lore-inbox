Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWBCKkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWBCKkE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWBCKkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:40:04 -0500
Received: from mail.gmx.net ([213.165.64.21]:39384 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751158AbWBCKkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:40:02 -0500
X-Authenticated: #428038
Date: Fri, 3 Feb 2006 11:39:57 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203103957.GA18205@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43DF3C3A.nail2RF112LAB@burner> <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com> <200601311333.36000.oliver@neukum.org> <1138867142.31458.3.camel@capoeira> <43E1EAD5.nail4R031RZ5A@burner> <1138880048.31458.31.camel@capoeira> <43E20047.nail4TP1PULVQ@burner> <20060202143202.3c2bd4a3.grundig@teleline.es> <43E32B11.nail5CA21ENV6@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E32B11.nail5CA21ENV6@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-03:

> Any new implementation first needs to prove that it is durable and (more 
> important) that it is actively maintained. I am sure that this kind of software 
> will never handle all oddities in drive firmware we know from CD/DVD-writers.

The suggestion was to use it for device enumeration and then talking
ioctl(...SG_IO...) to the device so obtained.

-- 
Matthias Andree
