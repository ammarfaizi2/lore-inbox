Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVDXENk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVDXENk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 00:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbVDXENk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 00:13:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:10647 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262142AbVDXENj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 00:13:39 -0400
Date: Sat, 23 Apr 2005 21:13:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050423211326.7ed8e199.pj@sgi.com>
In-Reply-To: <E1DPVwN-0007pj-00@calista.eckenfels.6bone.ka-ip.net>
References: <20050423174227.51360d63.pj@sgi.com>
	<E1DPVwN-0007pj-00@calista.eckenfels.6bone.ka-ip.net>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd wrote:
> Of course there are colliding files already available and easyly
> generate-able. So a malicous attack is already possible.

I don't believe you.  Reference?

> Or at least go with FIPS 180-2.

FIPS 180-2 specifies four secure hash algorithms - SHA-1, SHA-256, 
SHA-384, and SHA-512.  We're using SHA-1.

I think you meant go with SHA-256, which is new in FIPS 180-2. FIPS
180-1 only had SHA-1.  FIPS 180-2 superseded FIPS 180-1, adding three
the algorithms SHA-256, SHA-384, and SHA-512.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
