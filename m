Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTE3LjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 07:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTE3LjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 07:39:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:65240
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263590AbTE3LjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 07:39:24 -0400
Subject: Re: list_head debugging patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Morten Helgesen <morten.helgesen@nextframe.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030529210908.GD8978@holomorphy.com>
References: <20030529130807.GH19818@holomorphy.com>
	 <200305292158.52311.morten.helgesen@nextframe.net>
	 <20030529201337.GC8978@holomorphy.com>
	 <200305292303.19946.morten.helgesen@nextframe.net>
	 <20030529210908.GD8978@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054292079.23566.22.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 11:54:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-29 at 22:09, William Lee Irwin III wrote:
> On Thursday 29 May 2003 22:13, William Lee Irwin III wrote:
> >> Same thing; nuke the __list_head_check() check in list_empty()
> >> please.
> 
> On Thu, May 29, 2003 at 11:03:19PM +0200, Morten Helgesen wrote:
> > Ok, after having nuked __list_head_check() in list_empty() I can`t 
> > seem to trigger any more list corruption on this box.
> 
> Well, that's a hopeful sign; at some point maybe IDE will stop oopsing
> on me with it.

The IDE code has real list mangling bugs at probe. They are fixed in -ac
but I'm still waiting for the taskfile stuff to get sorted so I can do
a sane merge of the stuff pending.


