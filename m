Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVECQQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVECQQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVECQQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:16:44 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:48301 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261785AbVECQQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:16:42 -0400
Message-ID: <4277A3EB.30701@ammasso.com>
Date: Tue, 03 May 2005 11:16:43 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8: cannot specify -o with -c or -S and multiple compilations
References: <42779F6A.2000200@ammasso.com>
In-Reply-To: <42779F6A.2000200@ammasso.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:
> I just compiled and booted 2.6.11.8 over a Suse 9.2 system (2.6.8-24), 
> and when I try to compile an external module, I get this error:

Never mind.  I found a dumb typo in my makefile:

	EXTRA_CFLAGS += SIGNAL_RLIM

I was missing the -D.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
