Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSLZJ0w>; Thu, 26 Dec 2002 04:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSLZJ0w>; Thu, 26 Dec 2002 04:26:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:27309 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262821AbSLZJ0w>;
	Thu, 26 Dec 2002 04:26:52 -0500
Message-ID: <3E0ACD43.F27592FD@digeo.com>
Date: Thu, 26 Dec 2002 01:34:59 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: vda@port.imtp.ilyichevsk.odessa.ua, conma@kolivas.net,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Poor performance with 2.5.52, load and process in D state
References: <20021226092641.12371.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Dec 2002 09:35:00.0283 (UTC) FILETIME=[0F7628B0:01C2ACC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> > it appears that this benefit came from the special usercopy code.
> > What sort of CPU are you using?
> 
> It is a PIII@800.

hm, don't know.  I built the latest postgres locally.  Perhaps the
alignment of some application buffer is different.
