Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTENI1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTENI1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:27:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5391 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261328AbTENI1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:27:02 -0400
Date: Wed, 14 May 2003 09:37:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69: Missing logo?
Message-ID: <20030514093731.C26687@flint.arm.linux.org.uk>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030506180707.B15174@flint.arm.linux.org.uk> <Pine.LNX.4.44.0305132334140.12672-100000@phoenix.infradead.org> <20030513235528.H15172@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030513235528.H15172@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, May 13, 2003 at 11:55:28PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 11:55:28PM +0100, Russell King wrote:
> On Tue, May 13, 2003 at 11:41:34PM +0100, James Simmons wrote:
> > At the very bottom of cfbimgblt.c change 
> > 
> > } else if (image->depth == bpp)
> > 
> > to 
> > 
> > } else if (image->depth <= bpp)
> > 
> > and tell me if this works.
> 
> Will report later.

This change makes it work.  Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

