Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSFJVcO>; Mon, 10 Jun 2002 17:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316355AbSFJVcN>; Mon, 10 Jun 2002 17:32:13 -0400
Received: from [62.65.151.174] ([62.65.151.174]:38119 "EHLO zeus")
	by vger.kernel.org with ESMTP id <S316342AbSFJVcM>;
	Mon, 10 Jun 2002 17:32:12 -0400
Date: Mon, 10 Jun 2002 23:33:19 +0200
From: Mathias Gygax <mg@trash.net>
To: linux-kernel@vger.kernel.org
Subject: Re: removing old SYN packets
Message-ID: <20020610213319.GB13059@chiba.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200206102015.g5AKFk1l001840@debian01.kingruedi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 10:15:46PM +0200, Rüdiger Sonderfeld wrote:
> Hi,

hi there,

> I need some information about the TCP implementation. I didn't find any 
> information in my Linux Kernel book or in any other tutorial about TCP and I 
> do not really understand the tcp.c
> 
> The kernel should remove SYN packets if it doesn't recive the final ACK. But 
> where is that implemented in the Linux Kernel?

i guess it's in /usr/src/linux/net/ipv4/tcp_timer.c
