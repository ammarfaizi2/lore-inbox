Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbTDIVUv (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbTDIVUv (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:20:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:63487 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263821AbTDIVUu (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 17:20:50 -0400
Date: Wed, 09 Apr 2003 14:22:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_INPUT problems
Message-ID: <9530000.1049923334@flay>
In-Reply-To: <Pine.LNX.4.44.0304092316080.5042-100000@serv>
References: <193480000.1049909378@[10.10.2.4]> <Pine.LNX.4.44.0304092154320.5042-100000@serv><85360000.1049918540@flay> <Pine.LNX.4.44.0304092316080.5042-100000@serv>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > config INPUT
>> > 	default y if !HEADLESS
>> 
>> I don't see how that'll work ... we already have it defaulting to y,
>> but there's a previous setting that's 'n' from the 2.4 config file
>> they're upgrading from ... and that overrides the default, right?
> 
> A default without a visible prompt works like derived variable.
> If there is prompt, the .config value and the default value is used as 
> default input for the prompt.

Aha! that's perfect - thanks.

M.

