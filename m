Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUC3Qhz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbUC3Qhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:37:55 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:33190 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263736AbUC3Qhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:37:53 -0500
Subject: Re: Migrate pages from a ccNUMA node to another - patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Zoltan.Menyhart@bull.net
Cc: linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1080662328.10037.48.camel@nighthawk>
References: <4063F581.ACC5C511@nospam.org>
	 <1080321646.31638.105.camel@nighthawk>  <40695C68.4A5F551E@nospam.org>
	 <1080662328.10037.48.camel@nighthawk>
Content-Type: text/plain
Message-Id: <1080664633.10037.103.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 08:37:13 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 07:58, Dave Hansen wrote:
> I'm sure I missed some things, but I it's hard to look at the patch in
> depth functionally before it is cleaned up a bit.

One thing I forgot...

There don't appear to be any security checks in your syscall.  Should
all users be allowed to migrate memory around at will from any pid?

-- Dave

