Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315288AbSEACax>; Tue, 30 Apr 2002 22:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315289AbSEACaw>; Tue, 30 Apr 2002 22:30:52 -0400
Received: from mail.h8.ita.br ([161.24.72.4]:48779 "EHLO mail")
	by vger.kernel.org with ESMTP id <S315288AbSEACat>;
	Tue, 30 Apr 2002 22:30:49 -0400
Date: Tue, 30 Apr 2002 23:35:58 -0300
From: Carlos Francisco Regis <zeca@h8.ita.br>
To: linux-kernel@vger.kernel.org
Subject: smp/dac960/i450gx boot problem
Message-Id: <20020430233558.51bf6ed2.zeca@h8.ita.br>
Organization: ITA
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	
	Hello all,

	I'm with some troubles on trying to boot a kernel in a dual PPro machine. When a compile the kernel with smp support the machine hungs during the boot, this occurs exactly when the dac960 driver is being loaded. When I remove the smp support the driver is loaded but I have only one processor running.

	I think the problem is the i450kx/gx pci bridge and the pci->apic irq transform. But I can't figure out why this is happening.

	If someone knows some workaround, please let me know.


	Thanks in advance,

	Carlos

	

