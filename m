Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317290AbSFGOcR>; Fri, 7 Jun 2002 10:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317291AbSFGOcQ>; Fri, 7 Jun 2002 10:32:16 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:38397 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317290AbSFGOcP>; Fri, 7 Jun 2002 10:32:15 -0400
Subject: Re: Obscure networking question (shutdown on socket WITHOUT
	discarding data...)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020607024846.81BF37C8@merlin.webofficenow.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Jun 2002 16:25:38 +0100
Message-Id: <1023463538.25523.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-06 at 21:19, Rob Landley wrote:
> Is there a way to call shutdown(blah, SHUT_WR) on a network SOCK_STREAM 
> connection's fd without discarding pending output?  

Just call it. It doesn't discard pending output

