Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161432AbWKESK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161432AbWKESK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 13:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWKESK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 13:10:28 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15574 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161432AbWKESK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 13:10:27 -0500
Subject: Re: New filesystem for Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611051813440.1513@artax.karlin.mff.cuni.cz>
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
	 <1162691856.21654.61.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611051813440.1513@artax.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 05 Nov 2006 18:14:30 +0000
Message-Id: <1162750470.31873.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-11-05 am 18:18 +0100, ysgrifennodd Mikulas Patocka:
> Should IDE driver read back parameters after writing them before issuing 
> the command? That should fix this problem. (except when command
>  is written badly)

For "normal" usage I suspect not - the lack of ECC memory is probably
more serious as is the lack of PCI parity checking.


