Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSLQJDb>; Tue, 17 Dec 2002 04:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSLQJDb>; Tue, 17 Dec 2002 04:03:31 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:47883 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261364AbSLQJDa>; Tue, 17 Dec 2002 04:03:30 -0500
Message-Id: <200212170905.gBH95Ns16805@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Xavier LaRue <paxl@videotron.ca>, linux-kernel@vger.kernel.org
Subject: Re: My cpu fuzzy problem was due to XMMS
Date: Tue, 17 Dec 2002 11:54:39 -0200
X-Mailer: KMail [version 1.3.2]
References: <20021217011600.08f8cd81.paxl@videotron.ca>
In-Reply-To: <20021217011600.08f8cd81.paxl@videotron.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 December 2002 04:16, Xavier LaRue wrote:
> :).. I just found it out :)
>
> But now my real problem.. That probably slow down considerably my
> box, How to make my L2 cache reconized
> my dmesg is hosted here http://paxl.no-ip.org/~paxl/dmesg.txt

It does *NOT* slow down your box if kernel cannot parse
CPIUD cache size info. Cache does not need any help from kernel to function.
It is typically enabled by BIOS at boot, that's all.

If you can prove otherwise (that is, your cache is disabled),
that is a problem. Problem in BIOS.

Cache size *reporting* is a minor issue. You can track it yourself.
You have the code, right?
--
vda
