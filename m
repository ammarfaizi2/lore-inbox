Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbUKVC6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbUKVC6n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 21:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbUKVC5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 21:57:03 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:24715 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261903AbUKVCzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 21:55:35 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>
Subject: Re: [Linux-fbdev-devel] [2.6 patch] drivers/video/: misc cleanups
Date: Mon, 22 Nov 2004 10:54:44 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
References: <20041121153702.GB2829@stusta.de>
In-Reply-To: <20041121153702.GB2829@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411221054.48496.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 November 2004 23:37, Adrian Bunk wrote:
> The patch below does the following cleanups under drivers/video/ :
> - make some needlessly global code static
> - the following was needlessly EXPORT_SYMBOL'ed:
>   - fbcon.c: fb_con
>   - mdacon.c: fb_blank
>   - fbmon.c: get_EDID_from_firmware (completely unused)
>
> Please review this patch.

Looks ok.

Tony


