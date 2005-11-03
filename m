Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbVKCALP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVKCALP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVKCALP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:11:15 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:57505 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030215AbVKCALO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:11:14 -0500
Date: Thu, 3 Nov 2005 11:11:15 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS information leak during crash
Message-ID: <20051103111115.C6081538@wobbly.melbourne.sgi.com>
References: <20051102212722.GC6759@fi.muni.cz> <20051103101107.O6239737@wobbly.melbourne.sgi.com> <20051102233629.GD6759@fi.muni.cz> <20051103104956.B6081538@wobbly.melbourne.sgi.com> <20051103000317.GE6759@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051103000317.GE6759@fi.muni.cz>; from kas@fi.muni.cz on Thu, Nov 03, 2005 at 01:03:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 01:03:17AM +0100, Jan Kasprzak wrote:
> : it would only ever be uninitialised, previously-free space.
> 
> 	Yes, but an old data from previously deleted files
> (sendmail's temporary files, vim save files, etc) may contain
> a sensitive information.

Indeed.  But this is a generic issue affecting most filesystems;
its not specific to XFS as your original mail claimed.

cheers.

-- 
Nathan
