Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWASGkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWASGkJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWASGkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:40:08 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:21405 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964952AbWASGkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:40:07 -0500
Date: Wed, 18 Jan 2006 22:40:01 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: lethal@linux-sh.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       James.Bottomley@steeleye.com
Subject: Re: [PATCH] bitmap: Support for pages > BITS_PER_LONG.
Message-Id: <20060118224001.5d38d8bf.pj@sgi.com>
In-Reply-To: <20060118220753.3f005b5a.pj@sgi.com>
References: <20060119014812.GB18181@linux-sh.org>
	<20060118220753.3f005b5a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone unnamed has suggested I submit a patch with these cleanups.

But I am  lazy git who hates to test code, and it looks like Paul
Mundt is in a position to actually test that whatever we end up
with still works.

So I intend to send in two totally untested patches shortly:
 1) some minor cleanups of these bitmap routines, and
 2) Mundt's > BITS_PER_LONG patch, more or less, on top of that.

Then perhaps Mundt could retest and fix what I broke, then send in a
final pair of patches for Andrew's consideration.

If this isn't such a hot idea, Mundt, holler, and we can work
something else out.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
