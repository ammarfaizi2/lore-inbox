Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318915AbSHSPba>; Mon, 19 Aug 2002 11:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318922AbSHSPba>; Mon, 19 Aug 2002 11:31:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:12024 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318915AbSHSPb3>; Mon, 19 Aug 2002 11:31:29 -0400
Subject: Re: 2.4.20-pre2-ac2 pcmcia panic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Dreher <dreher@math.tsukuba.ac.jp>
Cc: linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu
In-Reply-To: <20020819150841.69B1113B47@abel.math.tsukuba.ac.jp>
References: <20020819150841.69B1113B47@abel.math.tsukuba.ac.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 16:35:32 +0100
Message-Id: <1029771332.19758.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 16:09, Michael Dreher wrote:
> 2.4.19-ac4 with pcmcia-cs-3.1.33 shows the same symptoms.
> 2.4.19-ac4 with pcmcia-cs-3.1.34 does not lock up, but also does not work.
> 
> Kernel pcmcia never worked on this box, so I had to resort to the version of
> David Hinds.

The later IDE almost certainly isnt compatible with David Hinds
pcmcia-cs ide module. The IDE updates that went into pre3 make it even
more definitely so.


