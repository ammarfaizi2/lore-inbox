Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262391AbSJ2RsP>; Tue, 29 Oct 2002 12:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbSJ2RsO>; Tue, 29 Oct 2002 12:48:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60173 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262391AbSJ2RsO>;
	Tue, 29 Oct 2002 12:48:14 -0500
Message-ID: <3DBECB3E.8000809@pobox.com>
Date: Tue, 29 Oct 2002 12:54:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Osamu Tomita <tomita@cinet.co.jp>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCHSET 8/23] add support for PC-9800 architecture (fs)
References: <20021029023017.A2319@precia.cinet.co.jp> <1035844431.1945.81.camel@irongate.swansea.linux.org.uk> <20021030021146.C4772@precia.cinet.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A general suggestion... some of your patches add headers to include/* 
directories, when they are only included from one location in the tree. 
 For that case, it is preferred to place the header in the same 
directory as the code which includes the header.


