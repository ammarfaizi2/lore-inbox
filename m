Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311616AbSCNNny>; Thu, 14 Mar 2002 08:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311617AbSCNNnp>; Thu, 14 Mar 2002 08:43:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311616AbSCNNnk>; Thu, 14 Mar 2002 08:43:40 -0500
Subject: Re: [patch] vmalloc_to_page() backport for 2.4
To: tigran@veritas.com (Tigran Aivazian)
Date: Thu, 14 Mar 2002 13:58:43 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kraxel@bytesex.org (Gerd Knorr),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (Kernel List), arjan@fenrus.demon.nl
In-Reply-To: <Pine.LNX.4.33.0203141219180.1643-100000@einstein.homenet> from "Tigran Aivazian" at Mar 14, 2002 12:30:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lVkh-0000oW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> help them be independent of PAE/non-PAE kernel configuration. And, as
> such, it suggests that the _GPL bit in the export clause is not justified
> and should be removed. There is no reason whatsoever why Linux base kernel
> should allow some useful functionality to GPL modules and disallow the
> same to non-GPL ones.

I disagree. The code in question is GPL code from a GPL driver or three that
was used internally in those drivers. It is now available for those drivers
to share. If you aren't writing a GPL module you can go write your own 
version of it, just like people have always had to before. 

Similarly the PAE/non-PAE thing is a red herring. Given that even basic
data types change size on pae no module is going to be magically pae/non-pae
clean if its binary only.

Alan
