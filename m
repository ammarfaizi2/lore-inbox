Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293233AbSCAAqj>; Thu, 28 Feb 2002 19:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293416AbSCAAk1>; Thu, 28 Feb 2002 19:40:27 -0500
Received: from h24-80-72-10.vn.shawcable.net ([24.80.72.10]:62724 "EHLO
	linisoft.localdomain") by vger.kernel.org with ESMTP
	id <S310285AbSCAAfn>; Thu, 28 Feb 2002 19:35:43 -0500
Message-ID: <3C7ECE99.E5B56663@linisoft.com>
Date: Thu, 28 Feb 2002 16:43:05 -0800
From: Reza Roboubi <reza@linisoft.com>
Organization: Linisoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Masoud Sharbiani <masouds@oeone.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Async IO using threads
In-Reply-To: <3C7CBB39.A6FC444@linisoft.com> <3C7D1964.2060903@oeone.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, I mentioned that I rewrote the test to do the "useful work" using
fifos, and that gave 0.45% of the CPU back during the read() operation.

Just in case anyone wants that test, it is on the web site with the
other test:

http://www.linisoft.com/test/asyncf.c  //async using fifo
http://www.linisoft.com/test/async.c  //async using __asm__(lock)
-- 
Reza
