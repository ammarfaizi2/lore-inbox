Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUESL0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUESL0P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUESLUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:20:46 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:28551 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263624AbUESLOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:14:31 -0400
Date: Wed, 19 May 2004 21:13:27 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Jan Kasprzak <kas@informatics.muni.cz>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: sendfile -EOVERFLOW on AMD64
Message-ID: <20040519211326.D574345@wobbly.melbourne.sgi.com>
References: <1XuW9-3G0-23@gated-at.bofh.it> <m3d650wys1.fsf@averell.firstfloor.org> <20040519103855.GF18896@fi.muni.cz> <20040519105805.GK30909@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040519105805.GK30909@devserv.devel.redhat.com>; from jakub@redhat.com on Wed, May 19, 2004 at 06:58:06AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 06:58:06AM -0400, Jakub Jelinek wrote:
> ...
> (note error is int, not ssize_t), but I don't see anything obvious
> for other filesystems.

Thanks, I'll fix that up.

cheers.

-- 
Nathan
