Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbTH0IW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 04:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTH0IW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 04:22:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30980 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263230AbTH0IW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 04:22:57 -0400
Date: Wed, 27 Aug 2003 09:22:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Marcus Hall <mhall@coraccess.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-arm-2.5.59 problem connecting from win 98
Message-ID: <20030827092254.A22441@flint.arm.linux.org.uk>
Mail-Followup-To: Marcus Hall <mhall@coraccess.com>,
	linux-kernel@vger.kernel.org
References: <3F4BD073.6020105@coraccess.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F4BD073.6020105@coraccess.com>; from mhall@coraccess.com on Tue, Aug 26, 2003 at 03:26:11PM -0600
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 03:26:11PM -0600, Marcus Hall wrote:
> Things work just fine with http/ftp/telnet from a linux box, but if I
> try to connect from a win 98 system, linux panics (don't really blame
> it..) with the error message 'kernel BUG at net/core/skbuff.c:323',
> which appears to say that an skbuff is being freed while still on a
> list.

Please supply the full backtrace - it may be a driver doing something it
shouldn't.

> I don't believe that there are any changes in the core networking in
> the arm/xscale patches applied to the base 2.5.59 kernel, just some
> tweaking of the smc9194 and cs89x0 modules.  It seems unlikely that this
> problem would exist in the "official" kernel for long, but it also seems
> unlikely to be particular to the arm either...  Is it a known bug
> (hopefully with a patch somewhere)?

The best I can advise is to upgrade to something more recent (eg, a
2.6.0-test kernel.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

