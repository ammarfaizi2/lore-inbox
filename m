Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272959AbTGaMhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 08:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272968AbTGaMhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 08:37:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53520 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272959AbTGaMhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 08:37:35 -0400
Date: Thu, 31 Jul 2003 13:37:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: regression serial console 2.6.0-test1 -> test2
Message-ID: <20030731133730.A8214@flint.arm.linux.org.uk>
Mail-Followup-To: Frank Cornelis <Frank.Cornelis@elis.ugent.be>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1059650626.1012.5.camel@tom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1059650626.1012.5.camel@tom>; from Frank.Cornelis@elis.ugent.be on Thu, Jul 31, 2003 at 01:23:46PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 01:23:46PM +0200, Frank Cornelis wrote:
> 'console=ttyS0,115200n8' worked fine for me until 2.6.0-test2 came
> along. I still get the kernel boot/shutdown messages, but no more kernel
> run-time messages. There were some changes to drivers/serial in
> test1->test2 which may be related to it.

Were there?  As the maintainer, I'm not aware of any changes to the
serial drivers between -test1 and -test2, but then I've only just got
back from OLS and I'm going to need about 36 hours to recover from
the jet lag before even thinking about looking at any code.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

