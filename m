Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131477AbRCWWVG>; Fri, 23 Mar 2001 17:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRCWWU5>; Fri, 23 Mar 2001 17:20:57 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4113 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131477AbRCWWUx>; Fri, 23 Mar 2001 17:20:53 -0500
Subject: Re: [PATCH] Prevent OOM from killing init
To: szaka@f-secure.com (Szabolcs Szakacsits)
Date: Fri, 23 Mar 2001 22:21:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dwguest@win.tue.nl (Guest section DW),
        stephenc@theiqgroup.com (Stephen Clouse),
        riel@conectiva.com.br (Rik van Riel),
        orourke@missioncriticallinux.com (Patrick O'Rourke),
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0103232159560.13864-100000@fs131-224.f-secure.com> from "Szabolcs Szakacsits" at Mar 23, 2001 10:09:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gZvi-0005YW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > and rely on it. You might find you need a few Gbytes of swap just to
> > boot
> 
> Seems a bit exaggeration ;) Here are numbers,

NetBSD is if I remember rightly still using a.out library styles. 

> 6-50% more VM and the performance hit also isn't so bad as it's thought
> (Eduardo Horvath sent a non-overcommit patch for Linux about one year
> ago).

The Linux performance hit would be so close to zero you shouldnt be able to
measure it - or it was in 1.2 anyway
