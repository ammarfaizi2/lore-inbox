Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264816AbSKELY7>; Tue, 5 Nov 2002 06:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264817AbSKELY7>; Tue, 5 Nov 2002 06:24:59 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:53396 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264816AbSKELY5>; Tue, 5 Nov 2002 06:24:57 -0500
Subject: Re: [RFC] FS charset conversions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1891J9-000B9X-00@f15.mail.ru>
References: <E1891J9-000B9X-00@f15.mail.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 11:53:37 +0000
Message-Id: <1036497217.4827.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 10:51, Samium Gromoff wrote:
>         The proposed and seemingly natural solution is to add a possibility
>     to mount --bind the subtree with a filename charset conversion applied.

The traditional unix approach is to declare the universe UTF-8. No
single character set is the right answer, UTF8 preserves "/" and \0
semantics so works very well indeed.

