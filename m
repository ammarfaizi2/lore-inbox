Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWITXBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWITXBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWITXBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:01:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32913 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932456AbWITXBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:01:15 -0400
Date: Wed, 20 Sep 2006 16:01:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: rohitseth@google.com, ckrm-tech@lists.sourceforge.net, devel@openvz.org,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <20060920155136.c35c874f.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0609201559380.1026@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
 <1158773208.8574.53.camel@galaxy.corp.google.com> <20060920155136.c35c874f.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Paul Jackson wrote:

> All in all, it could avoid anything more than trivial changes to the
> existing memory allocation code hot paths.  But the infrastructure
> needed for managing this mechanism needs some non-trivial work.

This is material we have to anyways for hotplug support. Adding a real 
node or a virtual node whatever it is fundamentally the same process that 
requires a regeneration of the zonelists in the system.
