Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVAGQI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVAGQI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVAGQI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:08:27 -0500
Received: from albireo.ucw.cz ([81.27.203.89]:52611 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261480AbVAGQIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:08:10 -0500
Date: Fri, 7 Jan 2005 17:08:08 +0100
From: Martin Mares <mj@ucw.cz>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107160808.GB6529@ucw.cz>
References: <20050107144718.GB9606@infradead.org> <200501071526.j07FQG2g018486@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071526.j07FQG2g018486@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Olaf:
> -----
> Capabilities don't work, because of missing filesystem
> capabilities. If you have them, it's a question of setting the
> appropriate permitted, inheritable and effective capability sets.

Sure, filesystem capabilities would be nice, but for the stuff Paul
mentions they aren't needed -- what you need is to grant capabilities
to the user's session, which can be easily done by a PAM module.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"C++: an octopus made by nailing extra legs onto a dog." -- Steve Taylor
