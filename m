Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTKTBHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 20:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTKTBHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 20:07:31 -0500
Received: from holomorphy.com ([199.26.172.102]:31659 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261193AbTKTBHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 20:07:30 -0500
Date: Wed, 19 Nov 2003 17:07:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031120010725.GY22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>,
	linux-kernel@vger.kernel.org
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar> <20031120002119.GA7875@localhost> <20031119170233.2619ba81.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119170233.2619ba81.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Luis Domingo Lopez <linux-kernel@24x7linux.com> wrote:
>> PS2: trying to "recompile" vmmon and vmnet again and starting VMware,
>> when tried to boot some guest OS I got the following in the logs:
>> kernel BUG at mm/memory.c:793!

On Wed, Nov 19, 2003 at 05:02:33PM -0800, Andrew Morton wrote:
> err, this is due to pagefault-accounting-fix.patch.  Looks like vmware has
> its own pagefault handler and Bill didn't update vmware ;)
> Bill, can we take those BUGs out of there and just do some sane default
> thing?

Sure, default == VM_FAULT_MINOR incoming ETA 5 minutes.


-- wli
