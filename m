Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270667AbTG0EbW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 00:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270668AbTG0EbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 00:31:21 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:56271 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270667AbTG0EbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 00:31:21 -0400
Message-ID: <3F235CEE.9080709@genebrew.com>
Date: Sun, 27 Jul 2003 01:02:38 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Tomas Szepe <szepe@pinerecords.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] sanitize power management config menus
References: <20030726200213.GD16160@louise.pinerecords.com>	<20030726194651.5e3f00bb.rddunlap@osdl.org>	<20030727025647.GB17724@louise.pinerecords.com> <20030726204623.47b08882.rddunlap@osdl.org>
In-Reply-To: <20030726204623.47b08882.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> +	  This creates an image which is saved in your active swap space. On
> +	  the next boot, pass the 'resume=/path/to/your/swap/file' option and
> +	  the kernel will detect the saved image, restore the memory from it,
> +	  and then continue to run as before you suspended.

Couple of points/questions:

- Is it possible to make swsusp use a dedicated hibernate partition, for 
better interoperability with Windows? I was thinking of the dual boot 
situation, where I would like a laptop to boot whatever OS was booted 
last. And how does s4bios fit in?

- Perhaps we can mention in the help text that swsusp performs a 
function similar to hibernate, and different from the APM suspend 
operation, with corresponding power savings.

Thanks,
Rahul

