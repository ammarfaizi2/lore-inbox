Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267640AbUBRRu3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267643AbUBRRu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:50:28 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:26379 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267640AbUBRRuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:50:25 -0500
Date: Wed, 18 Feb 2004 17:50:18 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
In-Reply-To: <20040217232130.61667965.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0402181742020.10389-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - Added the fbdev cursor API patch.  Not sure what this does apart from
>   preventing the rivafb driver from linking.  I'll let others decide if this
>   is progress.

Oops. Missed updating the rivafb driver. That is a easy fix. The current 
cursor api is focused on teh sofftware cursor. When I begain to program 
different hardware cursors I begain to realize it was a really bad design.
This patch breaks up the total cursor changes because it is quite big. 

P.S There is another bug I missed as well. 

I will send patches soon.


