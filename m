Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbUKNNsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbUKNNsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 08:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbUKNNsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 08:48:16 -0500
Received: from mail.aknet.ru ([217.67.122.194]:22792 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261304AbUKNNsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 08:48:13 -0500
Message-ID: <4197623B.4080500@aknet.ru>
Date: Sun, 14 Nov 2004 16:48:43 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
References: <41967669.3070707@aknet.ru> <21d7e99704111401242e713fb4@mail.gmail.com>
In-Reply-To: <21d7e99704111401242e713fb4@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Dave Airlie wrote:
>> [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
>> [drm:drm_unlock] *ERROR* Process 3124 using kernel context 0
> You are building AGP as a module with DRM as a built-in ,the DRM
Yes. Building everything as module fixes
the problem. Thanks.
One of those rare cases where you take the
.config from the functional kernel of another
version, and it produces the non-functional one.

> cannot use the AGP if it is not built in also, I think the latest DRM
> bk tree should enforce this I'm not sure if -mm5 has  the patches in
> it or not...
I bet it doesnt.

