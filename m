Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267481AbUG2Rcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267481AbUG2Rcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267545AbUG2Rad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:30:33 -0400
Received: from holomorphy.com ([207.189.100.168]:32917 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264501AbUG2R1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:27:15 -0400
Date: Thu, 29 Jul 2004 10:26:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Avi Kivity <avi@exanet.com>
Cc: jmoyer@redhat.com, suparna@in.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, linux-osdl@osdl.org
Subject: Re: [PATCH 20/22] AIO poll
Message-ID: <20040729172659.GU2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Avi Kivity <avi@exanet.com>, jmoyer@redhat.com, suparna@in.ibm.com,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org,
	linux-osdl@osdl.org
References: <20040702130030.GA4256@in.ibm.com> <20040702163946.GJ3450@in.ibm.com> <16649.5485.651481.534569@segfault.boston.redhat.com> <41091FAA.6080409@exanet.com> <20040729171037.GS2334@holomorphy.com> <410932C2.6080102@exanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410932C2.6080102@exanet.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> I just did it for OLS. The answer is busywait. i.e. 100% cpu. This is
>> because you can't use timeouts unless they're unified.

On Thu, Jul 29, 2004 at 08:24:18PM +0300, Avi Kivity wrote:
> That's not a server.

It accepted enough client connections and did enough work on behalf of
its clients to qualify as such.

Perhaps you have in mind that such a "solution" is inferior (which it is)?


-- wli
