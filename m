Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261878AbREMTmd>; Sun, 13 May 2001 15:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbREMTmX>; Sun, 13 May 2001 15:42:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58375 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261878AbREMTmN>; Sun, 13 May 2001 15:42:13 -0400
Subject: Re: Linux TCP impotency
To: clock@ghost.btnet.cz
Date: Sun, 13 May 2001 20:38:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010513213853.A5700@ghost.btnet.cz> from "clock@ghost.btnet.cz" at May 13, 2001 09:38:53 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14z1hV-0006sp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> causes the earlier started one to survive and the later to starve. Running bcp
> instead of the second (which uses UDP) at 11000 bytes per second caused the
> utilization in both directions to go up nearly to 100%.
> 
> Is this a normal TCP stack behaviour?

Yes. TCP is not fair. Look up 'capture effect' if you want to know more.
