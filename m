Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVK3F3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVK3F3r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVK3F3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:29:47 -0500
Received: from quark.didntduck.org ([69.55.226.66]:37338 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751050AbVK3F3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:29:46 -0500
Message-ID: <438D3982.2020000@didntduck.org>
Date: Wed, 30 Nov 2005 00:32:50 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Andrew Morton <akpm@osdl.org>, Erik Mouw <erik@harddisk-recovery.com>,
       linux-kernel@vger.kernel.org, jbglaw@lug-owl.de, torvalds@osdl.org
Subject: Re: [PATCH 2.6.15-rc2-git6] Fix tar-pkg target
References: <20051128170414.GA10601@harddisk-recovery.nl> <20051129133042.6d344110.akpm@osdl.org> <20051129203622.GA17053@mars.ravnborg.org>
In-Reply-To: <20051129203622.GA17053@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
>>
>> I already have the below queued up, which is a bit different.  Does it work
>> OK?
> 
> Brian's version preserve EXTRANAME, but I have not seen it
> used/documented anywhere?
> 
> 	Sam

Can probably get rid of EXTRANAME, unless it is meant to be set from the 
environment/cmdline.  I can't find any other reference to it.

--
				Brian Gerst
