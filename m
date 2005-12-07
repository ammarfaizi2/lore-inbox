Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbVLGSLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbVLGSLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbVLGSLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:11:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7699 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751643AbVLGSLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:11:46 -0500
Date: Wed, 7 Dec 2005 18:11:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Missing break in timedia serial setup.
Message-ID: <20051207181139.GH6793@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20051207010526.GA7258@redhat.com> <20051207093431.GB32365@flint.arm.linux.org.uk> <20051207165811.GA3574@redhat.com> <1133975119.2869.49.camel@laptopd505.fenrus.org> <20051207174409.GE3574@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207174409.GE3574@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 12:44:09PM -0500, Dave Jones wrote:
> On Wed, Dec 07, 2005 at 06:05:19PM +0100, Arjan van de Ven wrote:
> 
>  > might as well add a /* fall through */ comment
>  > so that this doesn't come up again in the future..
> 
> Remove redundant assignment, and mark fallthrough.

Thanks Dave, committed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
