Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWITVEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWITVEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWITVEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:04:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55430 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932084AbWITVEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:04:30 -0400
Date: Wed, 20 Sep 2006 14:04:01 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: sekharan@us.ibm.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920140401.39cc88ab.pj@sgi.com>
In-Reply-To: <6599ad830609201351k6d72067fpc86069ffb5bb60ba@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158777240.6536.89.camel@linuxchandra>
	<6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	<1158778496.6536.95.camel@linuxchandra>
	<6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	<20060920134903.fbd9fea8.pj@sgi.com>
	<6599ad830609201351k6d72067fpc86069ffb5bb60ba@mail.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M. wrote:
> I'm not saying that they can - but they could be parallel types of
> resource controller for a generic container abstraction,

When there are a sufficiently large number of sufficiently
similar types of objects, such as for example file systems,
then a 'generic container abstraction' such as vfs in the
file system case becomes well worth it, even essential.

I'll be surprised if we have enough such similarity between
cpusets and resource groups to be able to find a useful abstract
generalization that is common to them both.

But if someone finds a way to rewrite resource groups using
cpusets and can convince the resource group folks of this,
I'm game to consider it.

Just because some abstract generalizations are good doesn't
mean they all are.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
