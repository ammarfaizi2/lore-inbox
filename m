Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbUEFV55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUEFV55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUEFV55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:57:57 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:29536 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263101AbUEFV54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:57:56 -0400
Date: Thu, 6 May 2004 15:02:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cpumask cleanup patches dont build
Message-Id: <20040506150209.26a0a3ec.pj@sgi.com>
In-Reply-To: <20040506141312.A14209@unix-os.sc.intel.com>
References: <20040506141312.A14209@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right you are - that cpus_complement was inside an ifdef
CONFIG_HOTPLUG_CPU section that was added after I did my
global searches for such calls.  And obviously, you are
the first to build this with HOTPLUG enabled.

Thanks, Ashok.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
