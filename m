Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbUDGBsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 21:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUDGBsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 21:48:21 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:50162 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263425AbUDGBsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 21:48:18 -0400
Message-ID: <40735DE1.2020708@blueyonder.co.uk>
Date: Wed, 07 Apr 2004 02:48:17 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: mm-kernels, 4K stacks, and NVIDIA... am I crazy?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2004 01:48:19.0631 (UTC) FILETIME=[6718BBF0:01C41C42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Believe it, I inadvertently mangled one disk completely when I forgot 
and tried nvidia 5336 with 2.6.5-mm1 after I'd had success with 
2.6.5-clo1 and had another one not completing boot up before I knew of 
the problem. It would be nice if Andrew made it a config option until 
NVidia fixes the problem. There is a patch to change back from 4KSTACKS 
in the list recently. The last time, I changed it in .config then did a 
make oldconfig which changed it back and BOOM!
Regards
Sid.

On 2004-04-02 08:21:46 -0600 Norberto Bensa 
<norberto+linux-kernel@xxxxxxxxxxxx> wrote:

    Michael Baehr wrote:

        06:55:05 <+delysid|~> grep 4K /usr/src/linux/.config
        CONFIG_4KSTACKS=y
        06:55:08 <+delysid|~>

        And I have yet to have a single problem. In fact, everything is
        working swimmingly!


    Are you sure you are using nvidia's binary driver?

    $ dmesg | grep nvidia
    $ grep -i nvidia /var/log/XF*

    Regards,
    Norberto

    PS: I'm recompiling my kernel with 4KSTACKS, but I doubt it will work.


