Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265725AbUFDKo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265725AbUFDKo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 06:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUFDKo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 06:44:28 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:46284 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S265736AbUFDKoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 06:44:13 -0400
Date: Fri, 4 Jun 2004 12:40:35 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2
Message-ID: <20040604104033.GG19521@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040603015356.709813e9.akpm@osdl.org> <200406031703.38722.dominik.karall@gmx.net> <20040603161813.32ea0b84.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040603161813.32ea0b84.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.7-rc2-mm2 works fine, except for one thing: When my
init.d/setserial tries to set the saved state of the serial devices
using:

/bin/setserial -z /dev/ttyS0 uart 16550A port 0x03f8 irq 4 baud_base 115200 spd_normal skip_test

then the machine freezes. The magic sysrq keys don't work; I have to
cycle the power...

This happened with 2.6.7-rc2-mm2 and 2.6.7-rc2-mm1, it does work with
2.6.7-rc2-bk2.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
