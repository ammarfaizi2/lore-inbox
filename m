Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWIUAdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWIUAdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWIUAdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:33:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8346 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750834AbWIUAdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:33:31 -0400
Date: Wed, 20 Sep 2006 17:33:17 -0700
From: Paul Jackson <pj@sgi.com>
To: sekharan@us.ibm.com
Cc: menage@google.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920173317.2277bcce.pj@sgi.com>
In-Reply-To: <1158798607.6536.112.camel@linuxchandra>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158777240.6536.89.camel@linuxchandra>
	<6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	<1158778496.6536.95.camel@linuxchandra>
	<6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	<1158780923.6536.110.camel@linuxchandra>
	<6599ad830609201257m22605deei25ae6a0eadb6c516@mail.google.com>
	<1158798607.6536.112.camel@linuxchandra>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra wrote:
> What I am wondering is that whether the tight coupling of rg and cpuset
> (into a container data structure) is ok.

Just guessing wildly here, but I'd anticipate that at best we
(resource groups and cpusets) would share container mechanisms,
but not share the same container instances.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
