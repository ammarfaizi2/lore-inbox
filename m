Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWHGEem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWHGEem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 00:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWHGEem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 00:34:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:682 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751018AbWHGEel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 00:34:41 -0400
Date: Mon, 7 Aug 2006 14:34:16 +1000
From: Nathan Scott <nathans@sgi.com>
To: "Tony.Ho" <linux@idccenter.cn>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060807143416.A2501392@wobbly.melbourne.sgi.com>
References: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com> <20060804200549.A2414667@wobbly.melbourne.sgi.com> <44D55CE8.3090202@idccenter.cn> <44D56A97.2070603@idccenter.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44D56A97.2070603@idccenter.cn>; from linux@idccenter.cn on Sun, Aug 06, 2006 at 12:05:43PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 12:05:43PM +0800, Tony.Ho wrote:
> I'm sorry about prev mail. I test on a wrong kernel.
> The panic is not appear again,

Thanks for trying it, but I don't think that earlier patch is right.
I'll send out a new, improved patch to everyone who's reported this,
soon (tomorrow, hopefully).

> but random delete performance looks very bad.

This will be unrelated, and is probably due to the fact that we now
enable write barriers by default.

cheers.

-- 
Nathan
