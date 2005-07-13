Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVGMHJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVGMHJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 03:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVGMHJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 03:09:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46526 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262611AbVGMHJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 03:09:30 -0400
Date: Wed, 13 Jul 2005 00:09:23 -0700
From: Paul Jackson <pj@sgi.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
Message-Id: <20050713000923.1c9811b4.pj@sgi.com>
In-Reply-To: <20050711145616.GA22936@mellanox.co.il>
References: <20050711145616.GA22936@mellanox.co.il>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice work - thanks.

A couple of possible additions:

 * Keep lines within 80 columns.

 * Be consistent in use of tabs versus spaces.  If the
   rest of a file is indented using tabs, then any change
   you make should be indented the same way, not with
   spaces.  It is easy to unknowingly introduce spaces in
   a patch by cutting and pasting something in one of the
   many desktop UI environments that dont preserve tabs
   across a cut and paste.

 * See also Documentation/kernel-doc-nano-HOWTO.txt for
   formatting the documentation for external functions
   and data to work with the kernels DocBook automatically
   extractable documentation.

 * Multiline comments are shown as:

	/*
	 * This is a big comment.  It is full of sound
	 * and fury, signifying nothing. Now is the time
	 * for all good men to come to the aid of their
	 * country.
	 */

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
