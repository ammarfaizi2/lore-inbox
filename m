Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276244AbRJGJvF>; Sun, 7 Oct 2001 05:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276247AbRJGJu4>; Sun, 7 Oct 2001 05:50:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20484 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276244AbRJGJuv>; Sun, 7 Oct 2001 05:50:51 -0400
Subject: Re: Context switch times
To: george@mvista.com (george anzinger)
Date: Sun, 7 Oct 2001 10:56:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), bcrl@redhat.com (Benjamin LaHaise),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3BBFADDC.3FDE31E7@mvista.com> from "george anzinger" at Oct 06, 2001 06:20:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qAfb-0005IK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> its slice.  This would argue for priority being set at slice renewal
> time and left alone until the task blocks or completes its slice.

That may well be the case. The banding I played with was effectively 
doubling the task switch rate for more interactive tasks versus the bottom
feeders
