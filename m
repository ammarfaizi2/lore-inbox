Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSHZRLs>; Mon, 26 Aug 2002 13:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318142AbSHZRLs>; Mon, 26 Aug 2002 13:11:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:45053 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318136AbSHZRLr>; Mon, 26 Aug 2002 13:11:47 -0400
Subject: Re: problems with changing UID/GID
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Zheng Jian-Ming <zjm@cis.nctu.edu.tw>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 18:16:59 +0100
Message-Id: <1030382219.1751.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 15:58, Thunder from the hill wrote:
> I personally like the task->cred->cr_uid, etc. approach. Helps a lot.

It changes the whole semantics of every security test in Linux, and
breaks most of them totally. Our syscalls know the uid is constant
during the call

