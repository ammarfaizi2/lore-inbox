Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRDJLgF>; Tue, 10 Apr 2001 07:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRDJLfz>; Tue, 10 Apr 2001 07:35:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56580 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131480AbRDJLfr>; Tue, 10 Apr 2001 07:35:47 -0400
Subject: Re: Problems with Adaptec in 2.4.3
To: datageo@terra.com.br (Christoph Simon)
Date: Tue, 10 Apr 2001 12:37:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010410082250.0c207f75.datageo@terra.com.br> from "Christoph Simon" at Apr 10, 2001 08:22:50 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mwSX-00044f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> board. This worked well, but when I ran into a hang with the 2.4.2
> loop device, testing a CD image, I decided to switch to 2.4.3.  But
> then I get strange error messages during boot, and the machine reacts
> (kind of once a day) in a very strange way, like programs failing
> which never fail. Might those errors have lead to a subtile kind of

Simple way to test if its the new aic7xxx driver - build 2.4.3 with 
the old driver (say N to the new one and it'll offer you the old one) and
repeat the experiment

> 
