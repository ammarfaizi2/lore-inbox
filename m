Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbUDME2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbUDME2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:28:41 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:28968
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S263302AbUDME2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:28:38 -0400
thread-index: AcQhECO7CejiCx8nQkOsHGjLbG085Q==
X-Sieve: Server Sieve 2.2
Date: Tue, 13 Apr 2004 05:31:07 +0100
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Chris Friesen" <cfriesen@nortelnetworks.com>
Message-ID: <000001c42110$23d3e860$d100000a@sbs2003.local>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <Administrator@vger.kernel.org>
Cc: "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
Subject: Re: want to clarify powerpc assembly conventions in	head.S	and	entry.S
X-Mailer: Microsoft CDO for Exchange 2000
References: <4077A542.8030108@nortelnetworks.com>	 <1081591559.25144.174.camel@gaston>  <4078D42C.1020608@nortelnetworks.com>	 <1081661150.1380.183.camel@gaston>  <407AA848.2000008@nortelnetworks.com> <1081810459.1401.212.camel@gaston>
In-Reply-To: <1081810459.1401.212.camel@gaston>
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Envelope-to: paul@sumlocktest.fsnet.co.uk
X-me-spamlevel: not-spam
Content-Class: urn:content-classes:message
Importance: normal
X-me-spamrating: 11.987896
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-OriginalArrivalTime: 13 Apr 2004 04:31:07.0937 (UTC) FILETIME=[23F07110:01C42110]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt wrote:

> ret_from_syscall for syscalls, hash_page also has a different
> return to userland path, and load_up_{fpu,altivec} have their own
> retturn path.
> On ppc32 currently, the entry is almost always the same except for
> hash_page and load_up_{fpu,altivec}

Thanks, that's exactly the information I needed.

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


