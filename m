Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754376AbWKKLny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbWKKLny (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 06:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424552AbWKKLny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 06:43:54 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:12234 "EHLO
	torres.zugschlus.de") by vger.kernel.org with ESMTP
	id S1754374AbWKKLny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 06:43:54 -0500
Date: Sat, 11 Nov 2006 12:43:52 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: ttyS0 not working any more, LSR safety check engaged
Message-ID: <20061111114352.GA9206@torres.l21.ma.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since a few kernel versions (I unfortunately do not have logs going
back more than two months, 2.6.17.13), the serial port on my hp compaq
nc8000 is not working any more.

The Linux kernel logs "ttyS0: LSR safety check engaged!" whenever I
try to use the port. Googling for this error message suggests that the
port may either not be present or broken. I can confirm that both are
not the case: The port is present and works fine both on Windows and
with an older Knoppix version using a very old 2.6 kernel (I think
2.6.4).

Is it possible that a moderately recent update to the driver is
broken? What can I do to debug? What information do you need?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
