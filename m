Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbWHQSiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWHQSiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 14:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWHQSiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 14:38:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:4513 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932569AbWHQSiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 14:38:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C7L1kxh9Hiqxl6u40bcke5CdW6EDBnPR7LSdge0+21Ng83hZkq8/UtFgmHCsN/42rKWASkDkjgo1HnKHpHWVpnz3VCXS1hoJof6vUSyB8ycfSAgm2jI+s7UXrYght8TGwSGZcd1mVFne0vBQtQtPUlmX99epTO9J6U3zXQb45xc=
Message-ID: <d120d5000608171138p41b41ce2w38d62117f1817bd0@mail.gmail.com>
Date: Thu, 17 Aug 2006 14:38:53 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Bob Reinkemeyer" <bigbob73@charter.net>
Subject: Re: [bug] Mouse jumps randomly in x kernel 2.6.18
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44E37FD1.6020506@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44E37FD1.6020506@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/06, Bob Reinkemeyer <bigbob73@charter.net> wrote:
> I have an issue where my mouse jumps around the screen randomly in X
> only.  It works correctly in a vnc window.  The mouse is a Microsoft
> wireless optical intellimouse.  This was tested in 2.6.18-rc1-rc4 and
> observed in all. my config for .18 can be found here...
> http://rafb.net/paste/results/5cyWFd48.html
>
> and for .17 here...
> http://rafb.net/paste/results/xdFUkU58.html
>

Does it help if you revert this patch:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b0c9ad8e0ff154f8c4730b8c4383f49b846c97c4

-- 
Dmitry
