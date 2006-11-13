Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932831AbWKMTpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbWKMTpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbWKMTpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:45:10 -0500
Received: from cadalboia.ferrara.linux.it ([195.110.122.101]:36755 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S1755239AbWKMTpJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:45:09 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Remi <remi.colinet@free.fr>
Subject: Re: 2.6.19-rc5-mm1 : probe of 0000:00:1f.2 failed with error -16
Date: Mon, 13 Nov 2006 20:45:04 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <1163425477.455876c5637f6@imp4-g19.free.fr> <200611131654.27187.cova@ferrara.linux.it> <1163435230.45589cde18e04@imp4-g19.free.fr>
In-Reply-To: <1163435230.45589cde18e04@imp4-g19.free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611132045.05489.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 17:27, lunedì 13 novembre 2006, Remi ha scritto:

> > Not exactly: my fault to not including previous mails, but basically I've
> > two different devices: one driven by sata_sil, the other by piix.
> > cfr: http://lkml.org/lkml/2006/11/12/20
> > In this dmesg, the kernel finds only the second device, and assigns the
> > name "sda"; of course the right drive (the real "sda" on my system) is
> > not detected so the kernel is searching the "/" filesystem where it
> > cannot be found.


[...]

>
> ok,
>
> Could you try the following patch which solved the problemn on my laptop?


Confirmed, problem solved. Now 2.6.19-rc5-mm1 is booting just fine with your 
patch, well done.

Thanks.


-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
