Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287607AbSBGQCO>; Thu, 7 Feb 2002 11:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSBGQCF>; Thu, 7 Feb 2002 11:02:05 -0500
Received: from ns.suse.de ([213.95.15.193]:13066 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287289AbSBGQBz>;
	Thu, 7 Feb 2002 11:01:55 -0500
Date: Thu, 7 Feb 2002 17:01:54 +0100
From: Andi Kleen <ak@suse.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
Message-ID: <20020207170154.B15455@wotan.suse.de>
In-Reply-To: <3C6192A5.911D5B4F@nortelnetworks.com.suse.lists.linux.kernel> <p73it9a9mvc.fsf@oldwotan.suse.de> <3C62A47C.3BA52818@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C62A47C.3BA52818@nortelnetworks.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 10:59:56AM -0500, Chris Friesen wrote:
> Okay, I must be missing something, so can you enlighten me?  I can't figure out
> where the qdisc is attached to the ethernet device.

net/core/dev.c:dev_open -> dev_activate. 

-Andi
