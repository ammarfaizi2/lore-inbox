Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSE0NaJ>; Mon, 27 May 2002 09:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSE0NaI>; Mon, 27 May 2002 09:30:08 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:65532 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316608AbSE0NaI>; Mon, 27 May 2002 09:30:08 -0400
Subject: Re: [BUG] 2.4 VM sucks. Again
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200205271112.g4RBCH103186@mail.pronto.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 15:31:43 +0100
Message-Id: <1022509903.11811.282.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 12:12, Roy Sigurd Karlsbakk wrote:
> If I try to do ~50 simultanous reads from disk, it's no problem as long as 
> the data is being read from the nic with the same speed as it's being read 
> from disk. The server apps are running via inetd (testing), and have 2MB of 
> buffer each. (read 2MB from disk, write 2MB to NIC).
> 
> The server chrashes within minutes. The same problem occurs when using Tux
> 

How much physical memory and is your app using sendfile ?

