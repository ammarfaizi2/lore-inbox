Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263137AbUD2DPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUD2DPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUD2DPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:15:40 -0400
Received: from holomorphy.com ([207.189.100.168]:12929 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263137AbUD2DP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:15:29 -0400
Date: Wed, 28 Apr 2004 20:14:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429031419.GE737@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
	brettspamacct@fastclick.com, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40905127.3000001@fastclick.com> <20040428180038.73a38683.akpm@osdl.org> <16528.23219.17557.608276@cargo.ozlabs.ibm.com> <20040428185342.0f61ed48.akpm@osdl.org> <20040428194039.4b1f5d40.akpm@osdl.org> <16528.28485.996662.598051@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16528.28485.996662.598051@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 12:58:13PM +1000, Paul Mackerras wrote:
> The client/server thing is a bit misleading, what matters is the
> direction of the transfer.  In the case I saw this morning, the G5 was
> the sender.  In any case I was using the -W switch, which tells it not
> to use the rsync algorithm but just transfer the whole file.  So I
> believe that rsync on the G5 side was just reading the file through
> once.
> I have also noticed similar behaviour after doing a bk pull on a
> kernel tree.
> The really strange thing is that the behaviour seems to get worse the
> more RAM you have.  I haven't noticed any problem at all on my laptop
> with 768MB, only on the G5, which has 2.5GB.  (The laptop is still on
> 2.6.2-rc3 though, so I will try a newer kernel on it.)

Looks like you've got a system with an issue. Any chance you could send
logs from an instrumented test run?

Thanks.


-- wli
