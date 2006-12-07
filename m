Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032187AbWLGNBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032187AbWLGNBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 08:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032188AbWLGNBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 08:01:17 -0500
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:55854 "EHLO
	fest.stud.feec.vutbr.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032187AbWLGNBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 08:01:16 -0500
Message-ID: <4578107A.6050502@stud.feec.vutbr.cz>
Date: Thu, 07 Dec 2006 14:00:42 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Jaswinder Singh <jaswinderrajput@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: What happen when hangs !!
References: <aa5953d60612070421j1992fafcvb319d2237201eb3c@mail.gmail.com>
In-Reply-To: <aa5953d60612070421j1992fafcvb319d2237201eb3c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.177 () FROM_ENDS_IN_NUMS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:
> Sometimes my machine hangs in userspace area like this :-
> 
> VFS: Mounted root (ext3 filesystem).
> Freeing init memory: 124K
> INIT:
> <<HANGS>>
> 
> OR
> 
> VFS: Mounted root (ext3 filesystem).
> Freeing init memory: 124K
> INIT: version 2.85 booting
> <<RUNNING SMOOTHLY>>
> 
> How can I debug this hang, what are the cases.

When it hangs, try to capture the list of processes using Alt+SysRq+T. 
You need to have CONFIG_MAGIC_SYSRQ enabled in the kernel.

Michal
