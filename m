Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTFJOEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTFJODS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:03:18 -0400
Received: from rsys000a.roke.co.uk ([193.118.201.102]:34063 "HELO
	rsys000a.roke.co.uk") by vger.kernel.org with SMTP id S262850AbTFJOCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:02:37 -0400
From: "ZCane, Ed (Test Purposes)" <zed.cane@roke.co.uk>
To: Linux kernel <linux-kernel@vger.kernel.org>
Message-ID: <004901c32f5a$d68b2070$d8c176c1@roke.co.uk>
References: <Pine.LNX.4.53.0306100952560.4080@chaos>
Subject: Re: Large files
Date: Tue, 10 Jun 2003 15:16:08 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I'm allocating a large buffer at boot-time, from the kernel, using
alloc_bootmem_low_pages, which I wish to use for DMA from an device driver.

For example, the bootmem returns an address of 0xc0006000. This all works
fine, but...

What is the mechanism for communicating this address to user-space
processes, and mapping it to a virtual address, so that they can use my
buffer?

I want user-space processes to be able to read and write from this block of
memory, without having to be
suid root (if possible).

Cheers,

Ed




begin 666 RMRL-Disclaimer.txt
M4F5G:7-T97)E9"!/9F9I8V4Z(%)O:V4@36%N;W(@4F5S96%R8V@@3'1D+"!3
M:65M96YS($AO=7-E+"!/;&1B=7)Y+"!"<F%C:VYE;&PL( T*0F5R:W-H:7)E
M+B!21S$R(#A&6@T*#0I4:&4@:6YF;W)M871I;VX@8V]N=&%I;F5D(&EN('1H
M:7,@92UM86EL(&%N9"!A;GD@871T86-H;65N=',@:7,@8V]N9FED96YT:6%L
M('1O(%)O:V4@#0T-"DUA;F]R(%)E<V5A<F-H($QT9"!A;F0@;75S="!N;W0@
M8F4@<&%S<V5D('1O(&%N>2!T:&ER9"!P87)T>2!W:71H;W5T('!E<FUI<W-I
M;VXN(%1H:7,@#0T-"F-O;6UU;FEC871I;VX@:7,@9F]R(&EN9F]R;6%T:6]N
M(&]N;'D@86YD('-H86QL(&YO="!C<F5A=&4@;W(@8VAA;F=E(&%N>2!C;VYT
;<F%C='5A;" -#0T*<F5L871I;VYS:&EP+@T*
end

