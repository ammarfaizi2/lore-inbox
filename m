Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130406AbRCLO0x>; Mon, 12 Mar 2001 09:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130432AbRCLO0e>; Mon, 12 Mar 2001 09:26:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17938 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130406AbRCLO03>; Mon, 12 Mar 2001 09:26:29 -0500
Subject: Re: [kbuild-devel] Re: Rename all derived CONFIG variables
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 12 Mar 2001 14:28:01 +0000 (GMT)
Cc: esr@thyrsus.com, peter@cadcamlab.org (Peter Samuelson),
        linux-kernel@vger.kernel.org, elenstev@mesatop.com,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <24972.984388704@ocs3.ocs-net> from "Keith Owens" at Mar 12, 2001 08:18:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14cTIq-0001yq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The derived config variables should be in a separate name space,
> whether config is CML1 or CML2.  This patch does it for CML1.

Why ?

The only tool that needs to seperate them is the config check script and that
has enough information to deduce them

