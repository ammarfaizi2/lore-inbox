Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVBJD3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVBJD3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 22:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVBJD3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 22:29:33 -0500
Received: from almesberger.net ([63.105.73.238]:29715 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262011AbVBJD3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 22:29:31 -0500
Date: Thu, 10 Feb 2005 00:28:32 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Matt Mackall <mpm@selenic.com>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/8] lib/sort: turn off self-test
Message-ID: <20050210002832.D25338@almesberger.net>
References: <20050131074400.GL2891@waste.org> <20050131035742.1434944c.pj@sgi.com> <20050131170344.GP2891@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131170344.GP2891@waste.org>; from mpm@selenic.com on Mon, Jan 31, 2005 at 09:03:44AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> It's a nice self-contained unit test.

By the way, I think it would be useful if there was a more
formalized frame for such unit tests, so that they could be used
in automated kernel testing.

To avoid false positives when grepping through the code, perhaps
such tests could be placed in separate files, using a different
extension, e.g. .ct for ".c test", or in some "test" directory.
(That is, in case they're distributed along with the kernel code,
which, IMHO, would help to avoid code drift.)

Just an idea ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
