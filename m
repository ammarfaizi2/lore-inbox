Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVASRb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVASRb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVASRaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:30:52 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:46277 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S261788AbVASR2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:28:16 -0500
Date: Wed, 19 Jan 2005 19:28:12 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH - 2.6.10] generic_file_buffered_write handle partial DIO writes with multiple iovecs
Message-ID: <20050119172812.GR6725@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1106097764.3041.16.camel@ibm-c.pdx.osdl.net> <20050119023151.GK6725@m.safari.iki.fi> <1106153740.3041.42.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106153740.3041.42.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 08:55:40AM -0800, Daniel McNeil wrote:
> On Tue, 2005-01-18 at 18:31, Sami Farin wrote:
...
> > I have Linux 2.6.10-ac9 + bio clone memory corruption -patch,
> > and dio_bug does not give errors (without your patch).
> 
> I should have mentioned that my testing was on ext3 with 4k
> block size.   The bio clone patch might affect this by merging
> the i/o into a single iovec.  Here's an updated test program
> that uses 2 different buffers allocated separately that might
> prevent the merging.  See if this works on your system.

I have reiserfs... and this version does not give errors, either. 

-- 

