Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbVKSAKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbVKSAKm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 19:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVKSAKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 19:10:42 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:5774 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030266AbVKSAKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 19:10:42 -0500
Date: Fri, 18 Nov 2005 16:10:34 -0800
From: Paul Jackson <pj@sgi.com>
To: Avi Kivity <avi@argo.co.il>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool
Message-Id: <20051118161034.4ea38a09.pj@sgi.com>
In-Reply-To: <437E3CC2.6000003@argo.co.il>
References: <437E2C69.4000708@us.ibm.com>
	<437E2F22.6000809@argo.co.il>
	<437E30A8.1040307@us.ibm.com>
	<437E3CC2.6000003@argo.co.il>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi wrote:
> This may not be possible. What if subsystem A depends on subsystem B to 
> do its work, both are critical, and subsystem A allocated all the memory 
> reserve?

Apparently Matthew's subsystems have some knowable upper limits on
their critical memory needs, so that your scenario can be avoided.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
