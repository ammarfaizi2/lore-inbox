Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSDWOgx>; Tue, 23 Apr 2002 10:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315221AbSDWOgw>; Tue, 23 Apr 2002 10:36:52 -0400
Received: from lucy.ulatina.ac.cr ([163.178.60.3]:19977 "EHLO
	lucy.ulatina.ac.cr") by vger.kernel.org with ESMTP
	id <S315207AbSDWOgw>; Tue, 23 Apr 2002 10:36:52 -0400
Subject: Re: Adding snapshot capability to Linux
From: Alvaro Figueroa <fede2@fuerzag.ulatina.ac.cr>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200204230536.g3N5aDI05630@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 23 Apr 2002 08:30:22 -0600
Message-Id: <1019572222.800.6.camel@lucy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead of changing VFS you can probably make a generic stackable FS module 
> .....that can stack on top of the physical filesystems  and happily take 
> snapshots at "FS" level :) ! and you can use the FIST to create a basic 
> stackable FS and then modify it to take care of snapshoting !

Since this solution doens't solve Lisbor's request of using it on smb
filesystems, well, you could as well save up all of the programmer
cycles and use EVMS.

It has a pluggin for treating normal partitions as EVMS objets, so you
don't need to translate them or so; and with EVMS you can even use RW
snapshots.

-- 
Alvaro Figueroa

