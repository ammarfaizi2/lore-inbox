Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759825AbWLDFET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759825AbWLDFET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 00:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759831AbWLDFES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 00:04:18 -0500
Received: from main.gmane.org ([80.91.229.2]:18652 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1759820AbWLDFER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 00:04:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: CD oddities with VIA PATA
Date: Sun, 03 Dec 2006 21:03:53 -0800
Message-ID: <el0a7s$soj$1@sea.gmane.org>
References: <20061201220134.GA22909@deepthought.linux.bogus> <20061201224240.GB22909@deepthought.linux.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pub-148.casa-z.org
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.8) Gecko/20061129 Thunderbird/1.5.0.8 Mnenhy/0.7.4.0
In-Reply-To: <20061201224240.GB22909@deepthought.linux.bogus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2006 02:42 PM, Ken Moffat wrote:
> On Fri, Dec 01, 2006 at 10:01:34PM +0000, Ken Moffat wrote:
>> (i.) cdparanoia (9.8) works for root, but for a user it complains
>> that the ioctl isn't cooked and refuses to run.  For test purposes,
>> it runs ok for a user as suid root, but I imagine that increases
>> the likelihood of unspeakable things happening.  (Fortunately, I
>> don't have a dachshund)

For the record,
cdparanoia III release 10pre0 (August 29, 2006)

works for me. My particular IDE adapter is:

00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])

I have not tried older versions (yet). Could you try this and see if
things are still broken?

-- 
Joshua Kwan

