Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261611AbSJNMZ7>; Mon, 14 Oct 2002 08:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261612AbSJNMZ7>; Mon, 14 Oct 2002 08:25:59 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:4047 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S261611AbSJNMZ6>; Mon, 14 Oct 2002 08:25:58 -0400
Message-ID: <3DAAB958.9000700@quark.didntduck.org>
Date: Mon, 14 Oct 2002 08:32:24 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Romain Lievin <rlievin@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial API ('serport' ?)
References: <20021014090755.GB2911@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romain Lievin wrote:
> Hi,
> 
> I would like to know whether a kind of parport exists for the serial ports.
> This will allow me to do some low level accesses on the serial port pins (CTS/RTS & DSR/DTR).
> I need to implement a bit-banging access on the serial port which can coexist with the other serial ports.
> 
> I can not use request_region/release_region because the region has already been locked by the serial port driver.
> 
> Any idea ?

TTY line disciplines should be what you are looking for.

--
				Brian Gerst


