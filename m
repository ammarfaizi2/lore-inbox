Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWI2CmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWI2CmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWI2CmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:42:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:65459 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750882AbWI2CmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:42:01 -0400
Date: Thu, 28 Sep 2006 19:41:42 -0700
From: Paul Jackson <pj@sgi.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, jes@sgi.com, lse-tech@lists.sourceforge.net,
       sekharan@us.ibm.com, jtk@us.ibm.com, hch@lst.de,
       viro@zeniv.linux.org.uk, sgrubb@redhat.com, linux-audit@redhat.com,
       menage@google.com
Subject: Re: [RFC][PATCH 00/10] Task watchers v2 Introduction
Message-Id: <20060928194142.cece62bb.pj@sgi.com>
In-Reply-To: <20060929020232.756637000@us.ibm.com>
References: <20060929020232.756637000@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How might this play with Paul Menage's <menage@google.com> patch posted
earlier today on lkml:

  [RFC][PATCH 0/4] Generic container system

My cpuset_exit() call is getting popular - both you guys seem to have
designs on it.

Separate question - I guess that your task watcher mechanism, the
way it uses linker magic now, would not enable a loadable module
to plug into these various fork/exit/... hooks.  Is that right?

Such an ability for loadable modules to get callouts on fork/exit
would be useful to some ... it could also be a controversial ability.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
