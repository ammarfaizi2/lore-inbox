Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264348AbRFMDAs>; Tue, 12 Jun 2001 23:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264346AbRFMDAh>; Tue, 12 Jun 2001 23:00:37 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47004 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264348AbRFMDAY>;
	Tue, 12 Jun 2001 23:00:24 -0400
Message-ID: <3B26D739.944618E4@mandrakesoft.com>
Date: Tue, 12 Jun 2001 23:00:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mochel <mochel@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: New PCI PM
In-Reply-To: <Pine.LNX.4.10.10106121700580.13607-100000@nobelium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is are the guarantees about the order of calls to
pci_driver::suspend and pci_driver::resume?

Will a driver get calls like
	suspend(D3)
	suspend(D2)
	suspend(D1)

or just one suspend call?

What effect does the return value have on the rest of the system?  On
the order of succeeding calls to pci_driver::suspend functions?

And where is that patch to Documentation/pci.txt young man?  :)

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
