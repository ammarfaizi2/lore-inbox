Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754908AbWKKXoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908AbWKKXoz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 18:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754909AbWKKXoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 18:44:55 -0500
Received: from codepoet.org ([166.70.99.138]:22695 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1754905AbWKKXoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 18:44:54 -0500
Date: Sat, 11 Nov 2006 16:44:53 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFT] mv643xxx_eth_start_xmit oops
Message-ID: <20061111234452.GA2103@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
References: <20061110191745.GA13783@codepoet.org> <20061110115444.07f58e40@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110115444.07f58e40@freekitty>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Nov 10, 2006 at 11:54:44AM -0800, Stephen Hemminger wrote:
> The code int mv643xx_eth_start_xmit is not safe on SMP it was
> checking for space outside of lock.  Does the following
> (untested) fix it?

With your patch applied, I got the exact same oops a few minutes
ago while trying to rsync about a GB of stuff...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
