Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbRBMLSh>; Tue, 13 Feb 2001 06:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129546AbRBMLS1>; Tue, 13 Feb 2001 06:18:27 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34568 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129150AbRBMLSP>; Tue, 13 Feb 2001 06:18:15 -0500
Subject: Re: lost charaters -- this is becoming annoying!
To: tigran@veritas.com (Tigran Aivazian)
Date: Tue, 13 Feb 2001 11:18:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102130915490.927-100000@penguin.homenet> from "Tigran Aivazian" at Feb 13, 2001 09:20:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SdTi-0001TE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PS. This only happens on this Dell latitude CPx (notice lost shift in
> Latitude?) H450GT. 
> 
> PPS. No, my laptop is fine -- rebootingnto 2.2.x makes it type without
> loosing characters...

2.2 and 2.4 handle keyboard error cases quite differently (less so as of 2.2.18)
When you say 2.2.x works does that include 2.2.18.

The next stage then is probably to log when you see errored keyboard bytes

