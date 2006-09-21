Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWIUAF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWIUAF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWIUAF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:05:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16843 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750792AbWIUAF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:05:57 -0400
Date: Wed, 20 Sep 2006 17:05:44 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: rohitseth@google.com, ckrm-tech@lists.sourceforge.net, devel@openvz.org,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920170544.b4fd00f4.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609201651001.2055@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773208.8574.53.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
	<1158775678.8574.81.camel@galaxy.corp.google.com>
	<20060920155815.33b03991.pj@sgi.com>
	<Pine.LNX.4.64.0609201601450.1026@schroedinger.engr.sgi.com>
	<1158795231.7207.21.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201634450.1955@schroedinger.engr.sgi.com>
	<1158795569.7207.23.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201651001.2055@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Could we equip containers with restrictions on processors and nodes for 
> > > NUMA?
> > Yes.  That is something we will have to do (I think part of CPU
> > handler-TBD).
> 
> Paul: Will we still need cpusets if that is there?

Yes.  There's quite a bit more to cpusets than just some form,
any form, of CPU and Memory restriction.  I can't imagine that
Containers, in any form, are going to replicate that API.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
