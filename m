Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272561AbTG1BH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272560AbTG1ADw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:52 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272733AbTG0W6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:43 -0400
Subject: Re: time for some drivers to be removed?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "David D. Hagood" <wowbagger@sktc.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030727205638.GD22218@fs.tum.de>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
	 <20030727153118.GP22218@fs.tum.de> <3F23F6EB.7070502@sktc.net>
	 <1059324018.13442.0.camel@dhcp22.swansea.linux.org.uk>
	 <3F241DC0.7080408@sktc.net>
	 <1059338443.13875.2.camel@dhcp22.swansea.linux.org.uk>
	 <20030727205638.GD22218@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059339370.13871.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 21:56:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-27 at 21:56, Adrian Bunk wrote:
> That's no problem for me.
> 
> The only question is how to call the option that allows building only on
> UP (e.g. cli/sti usage in the driver)? My suggestion was BROKEN_ON_SMP,
> would you suggest OBSOLETE_ON_SMP?

Interesting question - whatever I guess. We don't have an existing convention.
How many drivers have we got nowdays that failing on just SMP ?
