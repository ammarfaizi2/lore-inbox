Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261811AbTC0IY4>; Thu, 27 Mar 2003 03:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261812AbTC0IYz>; Thu, 27 Mar 2003 03:24:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24324 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261811AbTC0IYz>; Thu, 27 Mar 2003 03:24:55 -0500
Date: Thu, 27 Mar 2003 08:36:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: missing sched.h comments
Message-ID: <20030327083605.A18292@flint.arm.linux.org.uk>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030327083124.GN1350@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030327083124.GN1350@holomorphy.com>; from wli@holomorphy.com on Thu, Mar 27, 2003 at 12:31:24AM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 12:31:24AM -0800, William Lee Irwin III wrote:
> (3) ->did_exec, ->leader, ->used_math, and ->keep_capabilities are all
> 	boolean, and may fit into the same word. Also comment them.

Please don't combine used_math - this is set by assembly code, and you
can't pass the bit offset of this to asm.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

