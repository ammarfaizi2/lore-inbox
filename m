Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269176AbRHQO2N>; Fri, 17 Aug 2001 10:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268859AbRHQO1y>; Fri, 17 Aug 2001 10:27:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6670 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269237AbRHQO1o>; Fri, 17 Aug 2001 10:27:44 -0400
Subject: Re: Promise Ultra100(20268) address conflict with ServerWorks IDE
To: W.Koenig@gsi.de (Koenig Dr. Wolfgang)
Date: Fri, 17 Aug 2001 15:30:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <no.id> from "Koenig Dr. Wolfgang" at Aug 17, 2001 04:18:07 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XkdS-0007PB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         I/O ports at 5440 [size=16]
> 
> // notice the gap at 5450-545F.
> // It will be allocated for the Serverworks IDE controller later.
> // This gap is only real, if size=16 is a true statement

The size data is read from the PCI card itself, which would lead me to
suspect we reserve to much maybe ?
