Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWAFJKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWAFJKH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 04:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWAFJKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 04:10:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6576 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932382AbWAFJKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 04:10:05 -0500
Date: Fri, 6 Jan 2006 04:09:46 -0500
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Allow iseries to disable input layer without CONFIG_EMBEDDED
Message-ID: <20060106090946.GD4595@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060106073819.GA731@redhat.com> <20060106090641.GA26504@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106090641.GA26504@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 09:06:41AM +0000, Christoph Hellwig wrote:
 > On Fri, Jan 06, 2006 at 02:38:19AM -0500, Dave Jones wrote:
 > > iSeries has no keyboard, so it's valid to build a kernel with no input layer.
 > > It seems a bit absurd to call one of these 'embedded'.
 > 
 > Please just remove the EMBEDDED here - there's tons of plattforms without
 > input that certainly aren't embedded.  In fact I've seen very few non-x86
 > servers with any input devices.

That's what the patch did :)

		Dave
