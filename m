Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267991AbTCCAJf>; Sun, 2 Mar 2003 19:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268013AbTCCAJf>; Sun, 2 Mar 2003 19:09:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10394
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267991AbTCCAJd>; Sun, 2 Mar 2003 19:09:33 -0500
Subject: Re: anyone ever done multicast AF_UNIX sockets?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303030005.h2305eWX002798@marajade.sandelman.ottawa.on.ca>
References: <200303030005.h2305eWX002798@marajade.sandelman.ottawa.on.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046654604.4431.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 01:23:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 00:05, Michael Richardson wrote:
>   First, multicast doesn't really work on loopback. I don't recall why...
>   One symptom of this is that one can't use the multicast transport for
> User-Mode-Linux when not "online" (i.e. on the train).

You have to specify you want your multicast packet looped back. By
default multicasts dont loop


