Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131363AbRCWUBL>; Fri, 23 Mar 2001 15:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131409AbRCWUBB>; Fri, 23 Mar 2001 15:01:01 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:28690 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S131363AbRCWUAp>; Fri, 23 Mar 2001 15:00:45 -0500
Date: Fri, 23 Mar 2001 22:09:23 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Guest section DW <dwguest@win.tue.nl>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <E14gEgX-0003Zr-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103232159560.13864-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Mar 2001, Alan Cox wrote:

> I'd like to have it there as an option. As to the default - You
> would have to see how much applications assume they can overcommit
> and rely on it. You might find you need a few Gbytes of swap just to
> boot

Seems a bit exaggeration ;) Here are numbers,

	http://lists.openresources.com/NetBSD/tech-userlevel/msg00722.html

6-50% more VM and the performance hit also isn't so bad as it's thought
(Eduardo Horvath sent a non-overcommit patch for Linux about one year
ago).

	Szaka

