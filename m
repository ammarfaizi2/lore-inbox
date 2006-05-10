Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWEJXmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWEJXmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWEJXmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:42:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44500 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965083AbWEJXmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:42:04 -0400
Date: Wed, 10 May 2006 16:42:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Adam Litke <agl@us.ibm.com>
cc: linux-mm@kvack.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Hugetlb demotion for x86
In-Reply-To: <1147287400.24029.81.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605101633140.7639@schroedinger.engr.sgi.com>
References: <1147287400.24029.81.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that the code is not modifying x86 code but all code. 

An app should be getting an out of memory error and not a SIGBUS when 
running out of memory.

I thought we fixed the SIGBUS problems and were now reporting out of 
memory? If there still is an issue then we better fix out of memory 
handling. Provide a way for the app to trap OOM conditions?

