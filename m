Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbUADAHt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUADAHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:07:48 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:22912 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S264372AbUADAHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:07:47 -0500
Date: Sun, 4 Jan 2004 01:07:47 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.24-pre3] 0/5  EXT2/3 Updates
Message-ID: <20040104000747.GA1706@janus>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <E1AcAhw-0000LE-Ky@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AcAhw-0000LE-Ky@thunk.org>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 04:50:20PM -0500, Theodore Ts'o wrote:
> Patch 5:  Add HTREE indexed directory support

Will this work on an NFS server? I remember an issue regarding a cookie
representing the directory offset: The problem was that the conversion
to HTREE of a directory while at the same time reading that directory
over NFS would basically invalidate the directory offset.

-- 
Frank
