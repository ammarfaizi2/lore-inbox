Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbUCATpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 14:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUCATpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 14:45:08 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:38670 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261412AbUCATpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 14:45:05 -0500
Date: Mon, 1 Mar 2004 19:45:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rik Faith <faith@redhat.com>, okir@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Light-weight Auditing Framework
Message-ID: <20040301194501.A9080@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rik Faith <faith@redhat.com>, okir@suse.de,
	linux-kernel@vger.kernel.org
References: <16451.25789.72815.763592@neuro.alephnull.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16451.25789.72815.763592@neuro.alephnull.com>; from faith@redhat.com on Mon, Mar 01, 2004 at 11:28:45AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 11:28:45AM -0500, Rik Faith wrote:
> This note describes a patch against 2.6.4-rc1-bk2 that provides a
> low-overhead system-call auditing framework for Linux that is usable by
> LSM components (e.g., SELinux).  Comments will be appreciated.

I haven't actually looked at the code, but why don't you use Olaf Kirch's
auditing framework that's used in production and already has gotten the
wizzbang certification you seem to be aiming at.

Whether we want syscall auditing in mainline is a completely different
question..

