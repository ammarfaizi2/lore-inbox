Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbSLKTAr>; Wed, 11 Dec 2002 14:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbSLKTAr>; Wed, 11 Dec 2002 14:00:47 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:37315
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267224AbSLKTAp>; Wed, 11 Dec 2002 14:00:45 -0500
Subject: Re: Bug Report 2.4.20: Interrupt sharing bogus
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20021211195501.7f6dff35.skraw@ithnet.com>
References: <20021211195501.7f6dff35.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 19:45:55 +0000
Message-Id: <1039635955.18587.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 18:55, Stephan von Krawczynski wrote:
> 4-port ethernet card. For tests I simply copy a lot of files via NFS to the
> local hd. It always freezes the machine, not always ad-hoc, but within short.
> I checked with 2.4.19 - same problem.
> I can test patches on this, no production machine involved. Any hints appreciated.

Not all systems get on with the 4 ports and bridge stuff. Also make sure
you have APIC disabled as the SiS io apic has some fun features 2.4
doesnt yet have workarounds for

