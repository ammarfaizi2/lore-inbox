Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWBHSe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWBHSe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWBHSe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:34:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20684 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030439AbWBHSe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:34:57 -0500
Date: Wed, 8 Feb 2006 10:34:48 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: clameter@engr.sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
Message-Id: <20060208103448.588fdfa7.pj@sgi.com>
In-Reply-To: <200602081914.00231.ak@suse.de>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
	<200602081914.00231.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> Ok I would have used an noinline function instead of putting the code inline
> to prevent register pressure etc. and make it more readable.

good idea.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
