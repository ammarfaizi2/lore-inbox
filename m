Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbULNHIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbULNHIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 02:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbULNHIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 02:08:13 -0500
Received: from almesberger.net ([63.105.73.238]:64780 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261441AbULNHIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 02:08:11 -0500
Date: Tue, 14 Dec 2004 04:07:52 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041214040752.B28617@almesberger.net>
References: <19865.1101395592@redhat.com> <cofv73$us3$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cofv73$us3$1@terminus.zytor.com>; from hpa@zytor.com on Mon, Nov 29, 2004 at 08:01:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Since we can't use typedefs on
> struct tags, I suggest:

Wouldn't this be a wonderful extension to ask from the gcc folks ?
typedef mumble struct foo; /* or union, enum */
with "mumble" either a "struct bar" or a typedef thereof.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
