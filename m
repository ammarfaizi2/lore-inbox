Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTJ3V3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTJ3V3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:29:44 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3523 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262861AbTJ3V3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:29:42 -0500
Subject: Re: [Lse-tech] Re: 2.6.0-test9-mjb1
From: Dave Hansen <haveblue@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Anton Blanchard <anton@samba.org>
In-Reply-To: <3FA17FEC.2080203@pobox.com>
References: <14860000.1067544022@flay>  <3FA171DD.5060406@pobox.com>
	 <1067548047.1028.19.camel@nighthawk>  <3FA17FEC.2080203@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1067549370.2657.38.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Oct 2003 13:29:30 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-30 at 13:17, Jeff Garzik wrote:
> well, there's still this patch...
>  void
> -e1000_io_write(struct e1000_hw *hw, uint32_t port, uint32_t value)
> +e1000_io_write(struct e1000_hw *hw, unsigned long port, uint32_t value)
>  {
>  	outl(value, port);
>  }

Whoops.  I just went looking in the breakout directory and didn't see it
in there.  I wonder where it was hidden.  

Anton, did this come from you?  Did it stop some warnings or something?
-- 
Dave Hansen
haveblue@us.ibm.com

