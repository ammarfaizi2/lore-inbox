Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWHYPmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWHYPmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWHYPmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:42:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44264 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422715AbWHYPmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:42:21 -0400
Date: Fri, 25 Aug 2006 08:42:11 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
In-Reply-To: <20060824234430.6AC970F7@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608250838410.9083@schroedinger.engr.sgi.com>
References: <20060824234430.6AC970F7@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is a good thing to do. However, the patch as it is now is 
difficult to review. Could you split the patch into multiple patches? One 
patch that introduces the generic functionality and then do one patch 
per arch? It would be best to sent the arch specific patches to the arch 
mailing list or the arch maintainer for review.

You probably can get the generic piece into mm together with the first 
arch specific patch (once the first arch has signed off) and then submit 
further bits as the reviews get completed.




