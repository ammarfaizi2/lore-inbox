Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUHSOyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUHSOyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266380AbUHSOvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:51:47 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:23815 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266352AbUHSOtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:49:02 -0400
Date: Thu, 19 Aug 2004 15:49:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: includes cleanup.
Message-ID: <20040819154900.A10013@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040819143907.GA4236@redhat.com>; from davej@redhat.com on Thu, Aug 19, 2004 at 03:39:07PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 03:39:07PM +0100, Dave Jones wrote:
> - split out the wake_up_* stuff to linux/wakeup.h

linux/wait.h sounds like a better choice because the other half of the
waitqueue operations are over there..

