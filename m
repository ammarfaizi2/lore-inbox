Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292391AbSBYXHF>; Mon, 25 Feb 2002 18:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292131AbSBYXGp>; Mon, 25 Feb 2002 18:06:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1286 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291152AbSBYXGi>; Mon, 25 Feb 2002 18:06:38 -0500
Subject: Re: setsockopt(SOL_SOCKET, SO_SNDBUF) broken on 2.4.18?
To: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Date: Mon, 25 Feb 2002 23:21:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a5ed9u$3tp$1@lyon.ram.loc> from "Raphael Manfredi" at Feb 25, 2002 10:19:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fUQq-0006iZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that I don't want to shrink the buffer size, hence I need
> to read the current size.  Do I need to halve the returned value from
> getsockopt() then?

The kernel always uses a buffer as big or bigger than you asked for
