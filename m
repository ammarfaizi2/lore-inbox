Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267279AbRGPLOd>; Mon, 16 Jul 2001 07:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267287AbRGPLOX>; Mon, 16 Jul 2001 07:14:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42504 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267281AbRGPLOQ>; Mon, 16 Jul 2001 07:14:16 -0400
Subject: Re: "oversized" files
To: yoda_2002@yahoo.com (Aaron Smith)
Date: Mon, 16 Jul 2001 12:15:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010715212006.A408@jacana.dyn.dhs.org> from "Aaron Smith" at Jul 15, 2001 09:20:07 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15M6LP-0005NU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a file that is approximately 3.25GB and my system keeps bitching about "Value too large for defined data type."  Is there any way to stop this?  Since I'm sure you're wondering why I have a file that large, I'm using it via loopback as my MP3 partition, so I can remove it fairly quick if the need should ever arise.

You need a 2.4 kernel and you need to be using NFSv3 to handle files >2Gb
