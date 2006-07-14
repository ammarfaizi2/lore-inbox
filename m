Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWGNIJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWGNIJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 04:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWGNIJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 04:09:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964806AbWGNIJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 04:09:09 -0400
Date: Fri, 14 Jul 2006 01:08:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: apw@shadowen.org, mbligh@google.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-git4 and 2.6.18-rc1-mm1 OOM's on boot
Message-Id: <20060714010858.d6824f1f.akpm@osdl.org>
In-Reply-To: <44B74F24.2060209@shadowen.org>
References: <44B528F4.6080409@google.com>
	<20060712181636.d7cbbb99.akpm@osdl.org>
	<44B5A0DD.9070200@google.com>
	<44B654EA.3030301@shadowen.org>
	<44B74F24.2060209@shadowen.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006 09:00:36 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> > Yep, I've run this with badari's fix as a set across the whole family. I 
> > did all dbenchall runs for now as this example is showing on that and 
> > badari's is triggered same.  If there is any measure of success there 
> > I'll throw in the externals too.
> 
> General goodness from this one.  Except where we're getting issues with 
> the e1000's.  That seems to be fixed up by backing out some driver changes.
> 
> All moot, as -mm2 is showing similar goodness.

Is -mm2's e1000 OK?
