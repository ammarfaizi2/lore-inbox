Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262499AbTCMSnP>; Thu, 13 Mar 2003 13:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262501AbTCMSnO>; Thu, 13 Mar 2003 13:43:14 -0500
Received: from air-2.osdl.org ([65.172.181.6]:54427 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262499AbTCMSnN>;
	Thu, 13 Mar 2003 13:43:13 -0500
Date: Thu, 13 Mar 2003 10:51:25 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       deanna_bonds@adaptec.com
Subject: Re: dpt_i2o.c fix for possibly memory corruption on reset timeout
Message-Id: <20030313105125.1548d67c.rddunlap@osdl.org>
In-Reply-To: <20030313184107.GA2334@linuxhacker.ru>
References: <20030313182819.GA2213@linuxhacker.ru>
	<1047584663.25948.75.camel@irongate.swansea.linux.org.uk>
	<20030313184107.GA2334@linuxhacker.ru>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003 21:41:07 +0300 Oleg Drokin <green@linuxhacker.ru> wrote:

| Ok, so please consider applying this patch instead (appies to both
| 2.4 and 2.5)

| +			/* We loose 4 bytes of "status" here, but we cannot
                              lose

| @@ -1336,6 +1338,9 @@
| +			/* We loose 4 bytes of "status" here, but we cannot
                              lose

--
~Randy
