Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbUJ0SiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbUJ0SiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUJ0S3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:29:11 -0400
Received: from delta.ece.northwestern.edu ([129.105.5.125]:19706 "EHLO
	delta.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S262559AbUJ0S20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:28:26 -0400
Message-ID: <417FE922.7080009@ece.northwestern.edu>
Date: Wed, 27 Oct 2004 13:29:54 -0500
From: Lei Yang <lya755@ece.northwestern.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Lei Yang <lya755@ece.northwestern.edu>
Subject: Re: loopback on block device
References: <417FE703.3070608@ece.northwestern.edu>
In-Reply-To: <417FE703.3070608@ece.northwestern.edu>
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc me if you have answers to this, I am not on the list. Thanks a 
lot!

Lei Yang wrote:

> Hello,
>
> Here is a question for loopback device. As far as I understand,  the 
> loopback device is used to mount files as if they were block devices.
>
> Then Why I could do "losetup -e XOR /dev/loop0 /dev/ram0" ? Notice 
> that ram0 is not mounted anywhere and does not have a filesystem on 
> it. I've tried that command and there seems to be no error. I got 
> confused and looked into loop.c, it seems to me that a loopback device 
> should be associated with a "backing file", why would it work on a 
> block device anyway?
>
> I'd appreciate your comments greatly!
>
> TIA,
> Lei
>


