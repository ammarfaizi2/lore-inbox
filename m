Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSD3T0e>; Tue, 30 Apr 2002 15:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSD3T0d>; Tue, 30 Apr 2002 15:26:33 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:44451 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S315179AbSD3T0c>; Tue, 30 Apr 2002 15:26:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: 2.5.11 ide kernel panic
Date: Tue, 30 Apr 2002 13:19:39 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <02042920011502.00813@cobra.linux> <3CCE5BED.9010809@evision-ventures.com>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02043013193900.01859@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Coudl you please remove the following code (or similar)
> from the ata_irq_request() function and see whatever the crash still
> happens? It could very well we that hwgroup->drive isn't
> initialized during boot under seom cirumstances.

the code is in function ide_do_request.
I tested removing it. The problem persists.



