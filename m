Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWCTVPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWCTVPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWCTVPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:15:21 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:37251 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1030370AbWCTVPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:15:19 -0500
Date: Mon, 20 Mar 2006 23:15:18 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Seth Goldberg <sethmeisterg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KBUILD_BASENAME hoses nvidia driver / vmware build processes
Message-ID: <20060320211518.GH3927@mea-ext.zmailer.org>
References: <d1064edf0603201308v4dab8355qee1dcfc9f9b5a611@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1064edf0603201308v4dab8355qee1dcfc9f9b5a611@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 01:08:30PM -0800, Seth Goldberg wrote:
> Hi,
> 
>    Just an FYI -- I just grabbed 2.6.16 and installed it without a
> problem.  However, when I went to rebuild the nvidia module and vmware
> modules, I discovered that the lack of a definition for
> KBUILD_BASENAME in linux/include/linux/spinlock.h cause these
> components' builds to fail.  I added a stupid workaround and was able
> to build and install these components, but I wanted to bring this to
> your attention.

Do post the note to Nvidia -- they need small fix in  conftest.sh
then things work mostly, but  I am not 100% sure that things do
work with 2.6.16  (this issue was with  nvsound   module, I think.)

>   Best wishes,
>   ---S

/Matti Aarnio
