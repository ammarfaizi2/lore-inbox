Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291389AbSBHDaG>; Thu, 7 Feb 2002 22:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291390AbSBHD34>; Thu, 7 Feb 2002 22:29:56 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:26614 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S291389AbSBHD3o>; Thu, 7 Feb 2002 22:29:44 -0500
From: flaniganr@intel.co.jp
X-Uptime: 12:29pm  up 100 days, 19:55,  2 users,  load average: 0.04, 0.08, 0.03
X-OS: Linux hazuki 2.4.5fa-1 #2 Fri Jun 1 12:55:37 JST 2001 i686 unknown
To: John Weber <weber@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.4-pre3 and IDE changes
In-Reply-To: <3C634346.1010405@nyc.rr.com>
X-Organization: IOS
X-Disclaimer: My opinions do not necessarily represent anything ...err those of my employer
Content-Type: text/plain; charset=US-ASCII
Date: 08 Feb 2002 12:29:39 +0900
In-Reply-To: John Weber's message of "Thu, 07 Feb 2002 22:17:26 -0500"
Message-ID: <87u1ssr6qk.fsf@hazuki.jp.intel.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Weber <weber@nyc.rr.com> writes:

    John> The address member of struct scatterlist appears to have
    John> been changed to dma_address.

was is changed to dma_address or was it
removed completely?

struct scatterlist {
-       /* This will disappear in 2.5.x */
-       char *address;

ryan
-- 
