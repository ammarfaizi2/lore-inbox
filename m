Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWHACix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWHACix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWHACix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:38:53 -0400
Received: from terminus.zytor.com ([192.83.249.54]:26850 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030398AbWHACiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:38:52 -0400
Message-ID: <44CEBEAF.8030203@zytor.com>
Date: Mon, 31 Jul 2006 19:38:39 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 built-in command line
References: <20060731171442.GI6908@waste.org> <200607312207.58999.ak@suse.de> <44CE6AEA.2090909@zytor.com> <200608010017.00826.ak@suse.de> <20060801014319.GO6908@waste.org>
In-Reply-To: <20060801014319.GO6908@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, the best thing to do might be to designate a symbol (say &, 
like in automount) as "insert the boot loader command line here."

That way you can specify things in the builtin command line that are 
both prepended and appended to the boot loader command, and if you wish, 
you can emit it completely.

The default would be just "&".

	-hpa

