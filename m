Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbTL3CQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 21:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTL3CQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 21:16:13 -0500
Received: from mail.designassembly.de ([217.115.138.177]:24015 "EHLO
	mail.designassembly.de") by vger.kernel.org with ESMTP
	id S264333AbTL3CQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 21:16:11 -0500
Message-ID: <3FF0DFE8.9080603@designassembly.de>
Date: Tue, 30 Dec 2003 03:16:08 +0100
From: Michael Heyse <m.heyse@designassembly.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Karel_Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't mount USB partition as root
References: <20031229173853.A32038@beton.cybernet.src> <Pine.LNX.4.58.0312300045070.24938@silk.corp.fedex.com> <20031229183302.B32137@beton.cybernet.src> <20031229174951.GA304@louise.pinerecords.com>
In-Reply-To: <20031229174951.GA304@louise.pinerecords.com>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>This is the problem #2. I am not able to remount /. "device or resource busy".
>>How do I remount the "/"?

I think you're looking for
     chroot NEWROOT [COMMAND...]
or
     pivot_root new_root put_old
here...

Greetings,

Michael
