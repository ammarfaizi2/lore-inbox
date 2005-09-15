Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVIOK0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVIOK0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 06:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVIOK0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 06:26:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7884 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932481AbVIOK0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 06:26:16 -0400
Date: Thu, 15 Sep 2005 12:28:05 +0200
From: Martin Mares <mj@ucw.cz>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 04/11] hpt366: write the full 4 bytes of ROM address, not just low 1 byte
Message-ID: <20050915102805.GA23778@atrey.karlin.mff.cuni.cz>
References: <20050915010343.577985000@localhost.localdomain> <20050915010404.660502000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915010404.660502000@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This is one heck of a confused driver.  It uses a byte write to a dword
> register to enable a ROM resource that it doesn't even seem to be using.

Once upon a time when I was the PCI maintainer, I was arguing with Andre
Hedrick about this one and he kept asserting that enabling the ROM is
necessary to make the chip work. Not that I believe it :)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Never make any mistaeks.
