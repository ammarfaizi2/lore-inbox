Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTFWHIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbTFWHIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:08:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24840 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263922AbTFWHIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:08:31 -0400
Date: Mon, 23 Jun 2003 08:22:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@redhat.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@cambridge.redhat.com>
Subject: Re: [PATCH] Fix mtdblock / mtdpart / mtdconcat
Message-ID: <20030623082235.A22114@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@redhat.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw2@cambridge.redhat.com>
References: <20030623010031.E16537@flint.arm.linux.org.uk> <1056352749.29264.0.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1056352749.29264.0.camel@passion.cambridge.redhat.com>; from dwmw2@redhat.com on Mon, Jun 23, 2003 at 08:19:09AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 08:19:09AM +0100, David Woodhouse wrote:
> On Mon, 2003-06-23 at 01:00, Russell King wrote:
> > Dirtily disable ECC support; it doesn't work when mtdpart is layered
> > on top of mtdconcat on top of CFI flash.
> 
> Please define "doesn't work".

Remember those errors I reported to you last night?  That "doesn't work".

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

