Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268954AbUIMUPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbUIMUPI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbUIMUMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:12:40 -0400
Received: from d193-185-141-10.elisa-laajakaista.fi ([193.185.141.10]:30863
	"EHLO mood.vph.iki.fi") by vger.kernel.org with ESMTP
	id S268929AbUIMULg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:11:36 -0400
Date: Mon, 13 Sep 2004 23:11:13 +0300
From: Ville Hallivuori <vph@iki.fi>
To: Paul Jakma <paul@clubi.ie>
Cc: Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Message-ID: <20040913201113.GA5453@vph.iki.fi>
Reply-To: vph@iki.fi
References: <002301c498ee$1e81d4c0$0200a8c0@wolf> <1095008692.11736.11.camel@localhost.localdomain> <20040912192331.GB8436@hout.vanvergehaald.nl> <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org> <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Sep 13, 2004 at 04:30:36AM +0100, Paul Jakma wrote:

> More specifically, BGP should have treated TCP resets as a transient 
> error, to be expected (indeed, they /cant/ be a sign that a link is 

Actually you can treat TCP session failure as transient error. Just
use BGP graceful restart (witch basically allows re-opening TCP
connection without losing routing tables).

http://www.ietf.org/internet-drafts/draft-ietf-idr-restart-10.txt

-- 
[Ville Hallivuori][vph@iki.fi][http://www.iki.fi/vph/]
[ID 8E1AD461][FP16=C9 50 E2 DF 48 F6 33 62  5D 87 47 9D 3F 2B 07 5D]
[ID 58543419][FP20=8731 941D 15AB D4A0 88A0  FC8F B55C F4C4 5854 3419]
[ID 8061C24E][FP20=C722 12DA 841E D811 DBFE  2FB3 174C E291 8061 C24E]
