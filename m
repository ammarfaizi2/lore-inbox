Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291069AbSAaNbk>; Thu, 31 Jan 2002 08:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291067AbSAaNba>; Thu, 31 Jan 2002 08:31:30 -0500
Received: from xi.linuxpower.cx ([204.214.10.168]:12293 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S291069AbSAaNbP>;
	Thu, 31 Jan 2002 08:31:15 -0500
Date: Thu, 31 Jan 2002 08:33:45 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Rob Landley <landley@trommello.org>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
Message-ID: <20020131083345.B12754@xi.linuxpower.cx>
In-Reply-To: <20020130212344.ZLSQ25963.femail43.sdc1.sfba.home.com@there> <Pine.LNX.3.95.1020130163406.21490A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <Pine.LNX.3.95.1020130163406.21490A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Jan 30, 2002 at 04:54:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 04:54:46PM -0500, Richard B. Johnson wrote:
> No. I set all sockets, even the original listen() socket to
> TCP_NODELAY. Nothing makes any difference. I tried it on a
[snip]

Nagle is a sending side thing, not listening.

It clearly explains your issue.
