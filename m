Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbTJPTqs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbTJPTqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:46:48 -0400
Received: from holomorphy.com ([66.224.33.161]:16517 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263110AbTJPTqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:46:47 -0400
Date: Thu, 16 Oct 2003 12:49:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: jbarnes@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: I/O errors in -test7-mm1 tree on ia64
Message-ID: <20031016194934.GB711@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	jbarnes@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20031016185505.GA1255@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016185505.GA1255@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 11:55:05AM -0700, Jesse Barnes wrote:
> I don't see this when using Linus' BK tree as of a few minutes ago, and
> the only changes I've made are adding the kgdb.h for ia64 and adding in
> the Altix console driver.  Any ideas?  I'll try reverting some patches
> and looking around a bit more.

Well, the first thing to try is backing out invalidate_inodes-speedup.patch


-- wli
