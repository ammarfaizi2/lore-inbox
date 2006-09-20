Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWITXqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWITXqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWITXqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:46:05 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37321 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750757AbWITXqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:46:02 -0400
Date: Wed, 20 Sep 2006 16:45:52 -0700
From: Paul Jackson <pj@sgi.com>
To: rohitseth@google.com
Cc: clameter@sgi.com, ckrm-tech@lists.sourceforge.net, devel@openvz.org,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920164552.0a95c481.pj@sgi.com>
In-Reply-To: <1158794542.7207.10.camel@galaxy.corp.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773208.8574.53.camel@galaxy.corp.google.com>
	<20060920155136.c35c874f.pj@sgi.com>
	<1158794542.7207.10.camel@galaxy.corp.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth wrote:
> But container support will allow the certain files pages to come from
> the same container irrespective of who is using them.  Something useful
> for shared libs etc.

Yes - that is useful for shared libs, and your container patch
apparently does that cleanly, while cpuset+fakenuma containers can
only provide a compromise kludge.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
