Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWAFJGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWAFJGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 04:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWAFJGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 04:06:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6891 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932378AbWAFJGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 04:06:42 -0500
Date: Fri, 6 Jan 2006 09:06:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Allow iseries to disable input layer without CONFIG_EMBEDDED
Message-ID: <20060106090641.GA26504@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060106073819.GA731@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106073819.GA731@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 02:38:19AM -0500, Dave Jones wrote:
> iSeries has no keyboard, so it's valid to build a kernel with no input layer.
> It seems a bit absurd to call one of these 'embedded'.

Please just remove the EMBEDDED here - there's tons of plattforms without
input that certainly aren't embedded.  In fact I've seen very few non-x86
servers with any input devices.

