Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbTDMDD2 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 23:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTDMDD2 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 23:03:28 -0400
Received: from holomorphy.com ([66.224.33.161]:30137 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263114AbTDMDD1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 23:03:27 -0400
Date: Sat, 12 Apr 2003 20:14:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeremy Hall <jhall@maoz.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.67-mm2
Message-ID: <20030413031440.GA14357@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jeremy Hall <jhall@maoz.com>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <1050198928.597.6.camel@teapot.felipe-alfaro.com> <200304130303.h3D33kkr031006@sith.maoz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304130303.h3D33kkr031006@sith.maoz.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 11:03:46PM -0400, Jeremy Hall wrote:
> I dunno about that, but mm2 locks in the boot process and doesn't display 
> anything to me through gdb even though it is supposed to.  I have gdb 
> console=gdb but that doesn't make the messages flow.

An early printk patch (any of the several going around) may give you an
idea of where it's barfing.


-- wli
