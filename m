Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992618AbWKAP3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992618AbWKAP3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 10:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992616AbWKAP3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 10:29:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49805 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2992615AbWKAP3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 10:29:40 -0500
From: Steve Grubb <sgrubb@redhat.com>
Organization: Red Hat
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] handle ext3 directory corruption better
Date: Wed, 1 Nov 2006 10:29:39 -0500
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200610211129.23216.sgrubb@redhat.com> <20061031095742.GA4241@ucw.cz>
In-Reply-To: <20061031095742.GA4241@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611011029.39295.sgrubb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 04:57, Pavel Machek wrote:
> Nice... can you run the same tool against fsck, too?

I'll see if I can make that work, too. The fuzzer tries to preserve the bad 
image so that you can replay the problem for debugging. I think its just a 
matter of making another copy and using that one instead.

-Steve
