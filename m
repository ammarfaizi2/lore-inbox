Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWELGqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWELGqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWELGqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:46:46 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:58154
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751009AbWELGqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:46:45 -0400
Message-Id: <44644B91.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 12 May 2006 08:47:13 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Christian Limpach" <Christian.Limpach@cl.cam.ac.uk>
Cc: <virtualization@lists.osdl.org>, <xen-devel@lists.xensource.com>,
       "Chris Wright" <chrisw@sous-sol.org>, <linux-kernel@vger.kernel.org>,
       "Zachary Amsden" <zach@vmware.com>,
       "Ian Pratt" <ian.pratt@xensource.com>
Subject: [Xen-devel] Re: [RFC PATCH 07/35] Make LOAD_OFFSET defined by
	subarch
References: <20060509084945.373541000@sous-sol.org> <20060509085150.509458000@sous-sol.org> <44627733.4010305@vmware.com> <20060511164300.GA7834@cl.cam.ac.uk>
In-Reply-To: <20060511164300.GA7834@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've updated our loader to support this now, so that this patch is
>no longer necessary.  I have at the same time added a new field to
>xen_guest which allows specifying the entry point, allowing us to have
>a different entry point when running the kernel image on Xen.

Why do you need a separate entry point here? The code should be able to figure out which mode it is run in without
problems...

Jan
