Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbUJNWOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbUJNWOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267638AbUJNWNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:13:53 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:36000 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267769AbUJNVym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:54:42 -0400
Message-ID: <9625752b04101414544ac90e1f@mail.gmail.com>
Date: Thu, 14 Oct 2004 14:54:40 -0700
From: Danny <dannydaemonic@gmail.com>
Reply-To: Danny <dannydaemonic@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: mm kernel oops with r8169 & named, PREEMPT
Cc: "netdev@oss.sgi.com Jon Mason" <jdmason@us.ibm.com>
In-Reply-To: <200410131703.21726.jdmason@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9625752b041012230068619e68@mail.gmail.com>
	 <200410131129.05657.jdmason@us.ltcfwd.linux.ibm.com>
	 <9625752b04101313283f035423@mail.gmail.com>
	 <200410131703.21726.jdmason@us.ltcfwd.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 17:03:21 -0500, Jon Mason wrote:
> The only thing that jumps out at me is the fact that you are running with
> Reiser4, but I don't want to point any fingers yet.  Please try recreating
> the error without NAPI and preemptable kernel, and if possible without
> Reiser4.

I can recreate it without NAPI and without the preemptable kernel, but
I have no means of recreating this with out Reiser4.  Would an oops
without the NAPI and preemptable kernel be more useful than the one I
already provided?  If so I can make another oops.

I spoke with Nikita shortly on OFTC and he said the oops "is not
related to reiser4, at least not directly. Maybe reiser4 corrupted
some internal data-structures some where in the kernel which caused
oops later."

Shrug.
