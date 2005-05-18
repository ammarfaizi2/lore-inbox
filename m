Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVERWQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVERWQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVERWQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:16:03 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:11648 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262379AbVERWPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:15:49 -0400
Message-ID: <428BBE54.8010904@ammasso.com>
Date: Wed, 18 May 2005 17:14:44 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: sparse error: unable to open 'stdarg.h'
References: <428A661C.1030100@ammasso.com> <428A729E.8040207@ammasso.com> <20050518182217.GA8130@mars.ravnborg.org>
In-Reply-To: <20050518182217.GA8130@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> Newer kbuild's do not use the -nostdinc -iwithprefix include trick.
> Instead they use -nostdinc -isystem `gcc --print-file-name=include`
> 
> Wich is a more reliable way to find stdarg.h. Newer sparse understands
> this too.
> 
> Please post make V=1 output with a newer kernel.

I downloaded and install 2.6.11.10, and everything works.  Thanks!

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
