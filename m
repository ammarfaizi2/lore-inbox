Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268538AbUIQHd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268538AbUIQHd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268533AbUIQHcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:32:43 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:61197 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268515AbUIQHbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:31:55 -0400
Date: Fri, 17 Sep 2004 08:31:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ray Bryant <raybry@sgi.com>
Cc: Ray Bryant <raybry@austin.rr.com>, Andrew Morton <akpm@osdl.org>,
       lse-tech@lists.sourceforge.net, "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] lockmeter: fixes
Message-ID: <20040917083127.F10537@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
	Andrew Morton <akpm@osdl.org>, lse-tech@lists.sourceforge.net,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
References: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com>; from raybry@sgi.com on Thu, Sep 16, 2004 at 04:03:44PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 04:03:44PM -0700, Ray Bryant wrote:
> Andrew,
> 
> The first patch in this series is a replacement patch for the prempt-fix
> patch I sent earlier this morning.  There was a missing paren in that
> previous version.

Any chance you could stop lockmeter patching around in fs/proc/proc_misc.c?
procfs files can be created easily from individual drivers.

