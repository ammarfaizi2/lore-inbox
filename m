Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314492AbSECPD6>; Fri, 3 May 2002 11:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314493AbSECPD5>; Fri, 3 May 2002 11:03:57 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:29944 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S314492AbSECPD5>; Fri, 3 May 2002 11:03:57 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0205022054160.8024-100000@conn6m.toms.net> 
To: Tom Oehser <tom@toms.net>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: module choices affecting base kernel size??? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 16:03:39 +0100
Message-ID: <11194.1020438219@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tom@toms.net said:
>  Any ideas on a reasonable way of how to identify them? 

A recursive grep for #if.*CONFIG_.*MODULE should find the majority of
offending code. As Keith says, some of it is in the Makefiles, but the 
majority is in the code.

--
dwmw2


