Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWEOITt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWEOITt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWEOITt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:19:49 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:19671 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S964791AbWEOITt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:19:49 -0400
Date: Mon, 15 May 2006 09:19:37 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com
Subject: Re: [RFC PATCH 08/35] Add Xen-specific memory management definitions
Message-ID: <20060515081937.GB10042@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085151.047254000@sous-sol.org> <20060514234418.65656de9.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060514234418.65656de9.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 11:44:18PM -0700, Pete Zaitcev wrote:
> I'm sure you considered this, but decided to be tricky. Why?
> No way to find the safe number of machine pages in a guest?

In addition to wanting to support holes, the number of machine
pages will usually change when you move it to another machine.

    christian

