Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272133AbTGYOwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 10:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272132AbTGYOwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 10:52:46 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42510 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S272133AbTGYOwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 10:52:45 -0400
Date: Fri, 25 Jul 2003 17:07:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: John Bradford <john@grabjohn.com>
cc: ecki-lkm@lina.inka.de, <Fabian.Frederick@prov-liege.be>,
       <rpjday@mindspring.com>, <linux-kernel@vger.kernel.org>
Subject: RE: why the current kernel config menu layout is a mess
In-Reply-To: <200307251458.h6PEwAMD001065@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0307251702340.717-100000@serv>
References: <200307251458.h6PEwAMD001065@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 25 Jul 2003, John Bradford wrote:

> Maybe a completely new, out of kernel tree configurator would be worth
> thinking about, leaving the in-kernel configurator as a legacy option.
> I know the config system underwent a major overhaul during 2.5, but I
> think we could go even further.

Maybe you should look first at something before you throw it away?
Kconfig is already modular, the Kconfig parser is a library, which you can 
easily connect to your favourite script language and then you can do with 
the Kconfig data whatever you want.

bye, Roman

