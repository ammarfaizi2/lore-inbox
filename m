Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbTA1Oix>; Tue, 28 Jan 2003 09:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266999AbTA1Oix>; Tue, 28 Jan 2003 09:38:53 -0500
Received: from ns.suse.de ([213.95.15.193]:56337 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266917AbTA1Oiv>;
	Tue, 28 Jan 2003 09:38:51 -0500
Date: Tue, 28 Jan 2003 15:48:10 +0100
From: Stefan Reinauer <stepan@suse.de>
To: John Bradford <john@grabjohn.com>
Cc: Raphael Schmid <Raphael_Schmid@CUBUS.COM>, rob@r-morris.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Bootscreen
Message-ID: <20030128144810.GA31303@suse.de>
References: <398E93A81CC5D311901600A0C9F29289469380@cubuss2> <200301281426.h0SEQRRn001008@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301281426.h0SEQRRn001008@darkstar.example.net>
User-Agent: Mutt/1.4i
X-Message-Flag: Life is too short to use a crappy OS.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Bradford <john@grabjohn.com> [030128 15:26]:
> At the moment, the framebuffer reserves a few lines for the Tux icons,
> and uses the rest for text.  Why not just modify that code to achieve
> what you want, (a large logo, and a text window).

Ack, besides:
You have to attach the huge logo to your kernel image. Using my
bootsplash patch allows you to use a plain and small jpg picture for
that (jpg because the decoder and the picture are smaller than a raw
picture gzipped)
ftp://ftp.suse.com/pub/people/stepan/bootsplash/

  Stefan

-- 
The use of COBOL cripples the mind; its teaching should, therefore, be
regarded as a criminal offense.                      -- E. W. Dijkstra
