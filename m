Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbTIYJyx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 05:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTIYJyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 05:54:53 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:15885 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261778AbTIYJyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 05:54:53 -0400
Date: Thu, 25 Sep 2003 10:54:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux/time.h annoyance
Message-ID: <20030925105436.A8809@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ronald Bultje <rbultje@ronald.bitfreak.net>,
	linux-kernel@vger.kernel.org
References: <1064483200.6405.442.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1064483200.6405.442.camel@shrek.bitfreak.net>; from rbultje@ronald.bitfreak.net on Thu, Sep 25, 2003 at 11:48:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 11:48:01AM +0200, Ronald Bultje wrote:
> Hi,
> 
> I'm annoyed by something in linux/time.h. The issue is as follows:
> 
> -
> #include <sys/time.h>
> #include <linux/time.h>
> int main () { return 0; }

So don't include it.  Userspace should use <sys/time.h>, not kernel
headers.

