Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbTIPObe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTIPObe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:31:34 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:43538 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261907AbTIPObb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:31:31 -0400
Date: Tue, 16 Sep 2003 11:33:27 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>, <neilb@cse.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
In-Reply-To: <20030916153658.3081af6c.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0309161132530.1636-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Sep 2003, Stephan von Krawczynski wrote:

> On Tue, 16 Sep 2003 10:11:49 -0300 (BRT)
> Marcelo Tosatti <marcelo.tosatti@cyclades.com.br> wrote:
> 
> > Oh... Jens just pointed bounce buffering is needed for the upper 2Gs. 
> > 
> > Maybe you have a SCSI card+disks to test ? 8)
> 
> Well, I do understand the bounce buffer problem, but honestly the current way
> of handling the situation seems questionable at least. If you ever tried such a
> system you notice it is a lot worse than just dumping the additional ram above
> 4GB. You can really watch your network connections go bogus which is just
> unacceptable. 

All is fine with 4GB? 

> Is there any thinkable way to ommit the bounce buffers and still
> do something useful with the beyond-4GB ram parts?
> We should not leave the current bad situation as is...

No way to omit the bounce buffers.

