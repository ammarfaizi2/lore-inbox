Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262329AbTCRLPs>; Tue, 18 Mar 2003 06:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262342AbTCRLPs>; Tue, 18 Mar 2003 06:15:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62440
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262329AbTCRLPr>; Tue, 18 Mar 2003 06:15:47 -0500
Subject: Re: FB error with trident CyberBlade/i1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303181002.18574.roy@karlsbakk.net>
References: <200303181002.18574.roy@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047991019.27171.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 18 Mar 2003 12:36:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 09:02, Roy Sigurd Karlsbakk wrote:
> hi all
> 
> I get a corrupted display with my Epox set-top-box if I enable the Trident 
> framebuffer device. See below for lspci -vvv, and further down for .config

Known: use the "epiafb" frame buffer driver (see sourceforge). That
should also keep the tv-out happy

