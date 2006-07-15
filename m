Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946016AbWGOIWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946016AbWGOIWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 04:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946015AbWGOIWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 04:22:05 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:62943 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1946016AbWGOIWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 04:22:04 -0400
Message-ID: <44B8A720.3030309@gentoo.org>
Date: Sat, 15 Jul 2006 09:28:16 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, stable@kernel.org,
       Marcel Holtmann <holtmann@redhat.com>
Subject: Re: Linux 2.6.17.5
References: <20060715030047.GC11167@kroah.com> <Pine.LNX.4.64.0607142217020.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607142217020.5623@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Torvalds wrote:
> I did a slight modification of the patch I committed initially, in the 
> face of the report from Marcel that the initial sledge-hammer approach 
> broke his hald setup.
> 
> See commit 9ee8ab9fbf21e6b87ad227cd46c0a4be41ab749b: "Relax /proc fix a 
> bit", which should still fix the bug (can somebody verify? I'm 100% sure, 
> but still..), but is pretty much guaranteed to not have any secondary side 
> effects.
> 
> It still leaves the whole issue of whether /proc should honor chmod AT ALL 
> open, and I'd love to close that one, but from a "minimal fix" standpoint, 
> I think it's a reasonable (and simple) patch.
> 
> Marcel, can you check current git?

I can confirm that the new fix prevents the exploit from working, with 
no immediately visible side effects.

Thanks,
Daniel

