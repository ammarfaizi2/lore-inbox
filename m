Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSE2M0s>; Wed, 29 May 2002 08:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315206AbSE2M0r>; Wed, 29 May 2002 08:26:47 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:14325 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315202AbSE2M0q>; Wed, 29 May 2002 08:26:46 -0400
Subject: Re: wait queue process state
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Benjamin LaHaise <bcrl@redhat.com>,
        jw schultz <jw@pegasys.ws>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0205291351120.17583-100000@serv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 14:29:22 +0100
Message-Id: <1022678962.9255.191.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 12:55, Roman Zippel wrote:
> It's possible to automatically restart stat(), so the process would be at
> least killable.
>
Good point. The problem does indeed only arrive for a signal that is
being caught and won't kill the process. That makes a lot of sense

