Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSG1XQP>; Sun, 28 Jul 2002 19:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSG1XQP>; Sun, 28 Jul 2002 19:16:15 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9462 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317387AbSG1XQP>; Sun, 28 Jul 2002 19:16:15 -0400
Subject: Re: traffic shaper in 2.4.18 working?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benson Chow <blc+lkml-post@q.dyndns.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207281337330.1415-100000@q.dyndns.org>
References: <Pine.LNX.4.44.0207281337330.1415-100000@q.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jul 2002 01:34:57 +0100
Message-Id: <1027902897.808.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-28 at 20:56, Benson Chow wrote:
> However, it seems whenever I subsequently connect to this
> machine's 10.0.0.80 from another machine, it still transmits at full
> bandwidth of the media and not the 19K (Bytes/sec?) that I expect?
> 
> Is this a proper usage of this device or is it a bug?
 
You need to route via shaper0 too

