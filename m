Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbTIALsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 07:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbTIALsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 07:48:23 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:11718 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262515AbTIALsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 07:48:18 -0400
Subject: Re: Andrea VM changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Chris Frey <cdfrey@netdirect.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030831234211.GB29239@mail.jlokier.co.uk>
References: <3F52199B.5020808@kegel.com>
	 <20030831152246.A32685@netdirect.ca>
	 <20030831234211.GB29239@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062416841.13327.20.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 01 Sep 2003 12:47:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-01 at 00:42, Jamie Lokier wrote:
> I once ran GCC on a box out there in netland, on a short bit of code,
> and it was a surprise memory hog due to the usual GCC surprises.

Run -ac on remote boxes and turn on no overcommit. Paranoid people also
run watchdog drivers set to NOWAYOUT and monitor a list of apps to be
sure they are there - if the app is gone, or the watchdog app dies the
box will reboot.

