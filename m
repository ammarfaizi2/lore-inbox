Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132248AbRCVXoC>; Thu, 22 Mar 2001 18:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132264AbRCVXlu>; Thu, 22 Mar 2001 18:41:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44298 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132257AbRCVXkD>; Thu, 22 Mar 2001 18:40:03 -0500
Subject: Re: [PATCH] Prevent OOM from killing init
To: dledford@redhat.com (Doug Ledford)
Date: Thu, 22 Mar 2001 23:40:54 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        stephenc@theiqgroup.com (Stephen Clouse),
        dwguest@win.tue.nl (Guest section DW),
        riel@conectiva.com.br (Rik van Riel),
        orourke@missioncriticallinux.com (Patrick O'Rourke),
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <3ABA8B02.F28B333A@redhat.com> from "Doug Ledford" at Mar 22, 2001 06:30:10 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gEhM-0003a2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ummm, yeah, that would pretty much be the claim.  Real easy to reproduce too. 
> Take your favorite machine with lots of RAM, run just a handful of startup
> process and system daemons, then log in on a few terminals and do:
> 
> while true; do bonnie -s (1/2 ram); done
> 
> Pretty soon, system daemons will start to die.

Then thats a bug. I assume you've provided Rik with a detailed test case 
already ?
