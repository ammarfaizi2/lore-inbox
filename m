Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbTHVO4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 10:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTHVO4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 10:56:12 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:62179 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263116AbTHVO4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 10:56:09 -0400
Date: Fri, 22 Aug 2003 15:55:15 +0100
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com,
       aj@suse.de
Subject: Re: Cpufreq for opteron
Message-ID: <20030822145515.GA21061@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com,
	aj@suse.de
References: <20030822135946.GA2194@elf.ucw.cz> <20030822155207.A17469@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822155207.A17469@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 03:52:07PM +0100, Christoph Hellwig wrote:
 > On Fri, Aug 22, 2003 at 03:59:46PM +0200, Pavel Machek wrote:
 > > +	tristate "AMD K8 PowerNow!"
 > > +	depends on CPU_FREQ_TABLE
 > 
 > shouldn't be this
 > 	
 > 	depends on CPU_FREQ?

It implies CPU_FREQ. It's basically saying

	depends on CPU_FREQ && CPU_FREQ_TABLE

But in a shorthand..

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
