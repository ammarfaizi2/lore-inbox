Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267484AbUG2Qlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267484AbUG2Qlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUG2Qjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:39:35 -0400
Received: from kanga.kvack.org ([66.96.29.28]:45032 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S264770AbUG2Qh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:37:58 -0400
Date: Thu, 29 Jul 2004 12:37:50 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Avi Kivity <avi@exanet.com>, jmoyer@redhat.com, suparna@in.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org, linux-osdl@osdl.org
Subject: Re: [PATCH 20/22] AIO poll
Message-ID: <20040729163750.GH756@kvack.org>
References: <20040702130030.GA4256@in.ibm.com> <20040702163946.GJ3450@in.ibm.com> <16649.5485.651481.534569@segfault.boston.redhat.com> <41091FAA.6080409@exanet.com> <1091117766.2792.14.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091117766.2792.14.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 06:16:07PM +0200, Arjan van de Ven wrote:
> one could try to use epoll and fix it to be usable for disk io too ;)

How would that make it possible to have multiple ios at different offsets 
in flight?

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
