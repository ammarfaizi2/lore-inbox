Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264967AbRFZPE4>; Tue, 26 Jun 2001 11:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264970AbRFZPEq>; Tue, 26 Jun 2001 11:04:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27399 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264967AbRFZPEh>; Tue, 26 Jun 2001 11:04:37 -0400
Subject: Re: Problems with 2.4.5ac1[78]
To: mccramer@s.netic.de (Meino Christian Cramer)
Date: Tue, 26 Jun 2001 16:04:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010626161854G.mccramer@s.netic.de> from "Meino Christian Cramer" at Jun 26, 2001 04:18:54 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15EuO6-0003dz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I tried to compile linux-2.4.5ac17 with processor type "Athlon"
>  settings.
> 
>  Compilation/Install was successful. But boot produces dozens of
>  "unresolved symbols" if trying to insmod any of the modules.
> 
>  Not one module was insmodded successfully.

Sounds like your build wasnt clean. Save your .config file and make distclean
is sometimes needed when changing SMP or CPU types - yes its a bug in the
config setup really

