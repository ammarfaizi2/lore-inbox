Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267303AbRGPLjj>; Mon, 16 Jul 2001 07:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267305AbRGPLj2>; Mon, 16 Jul 2001 07:39:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49672 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267303AbRGPLjR>; Mon, 16 Jul 2001 07:39:17 -0400
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
To: johnc@damncats.org (John Cavan)
Date: Mon, 16 Jul 2001 12:39:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B52CEAF.12281126@damncats.org> from "John Cavan" at Jul 16, 2001 07:23:27 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15M6jC-0005PK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why not do something similar to the aic7xxx driver? Place the old DRM in
> code in a pre-X4.1.0 subdirectory, with a warning that it will become
> obsolete as of 2.5, and bring in the new code. When you build the
> kernel, you can then choose which DRM version you want and everybody is
> happy.

Thats certainly possible, Ideally you would want both module sets to 
co-exist. That way the user can build all of DRM and get the right ones loading
via modprobe

Alan

