Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265481AbUFWPCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265481AbUFWPCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUFWPCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:02:19 -0400
Received: from [213.146.154.40] ([213.146.154.40]:64663 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265481AbUFWPCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:02:14 -0400
Date: Wed, 23 Jun 2004 16:02:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, erikj@sgi.com,
       devices@lanana.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040623150210.GA24133@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, erikj@sgi.com, devices@lanana.org
References: <20040622183621.GA7490@infradead.org> <Pine.SGI.3.96.1040623094018.19458B-100000@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.3.96.1040623094018.19458B-100000@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 09:42:17AM -0500, Pat Gefre wrote:
> Guess I should have said "different" major/minor. We have asked lanana
> for our own major/minor - but, as yet, no response.... So we picked a
> different one.

Please wait a resonse from LANANA then.  As you already have that support
just kill the SYSFS_ONLY ifdef (which is grossly misnamed, btw - people have
used dynamic majors and minnors long before sysfs was invented)
