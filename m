Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWHVLxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWHVLxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWHVLxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:53:34 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:9712 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751209AbWHVLxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:53:33 -0400
Date: Tue, 22 Aug 2006 13:43:30 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Daniel J Blueman <daniel.blueman@gmail.com>
Subject: Re: sky2 doesn't receive any packages after I ssh in via ipv6 and edit a file in vim (reproducable)
Message-ID: <20060822114330.GG18587@cip.informatik.uni-erlangen.de>
References: <6278d2220608220228x46010973p52bd4eeac34113@mail.gmail.com> <20060822104130.GC18587@cip.informatik.uni-erlangen.de> <6278d2220608220412s3df3a1c1wc9e3a3daab9c8555@mail.gmail.com> <20060822111659.GE18587@cip.informatik.uni-erlangen.de> <6278d2220608220429w7209eae1g26b29315604e3518@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6278d2220608220429w7209eae1g26b29315604e3518@mail.gmail.com>
User-Agent: Mutt/1.5.11-2006-07-11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

> # ethtool -K eth0 rx off

> It would be interesting if you can see if this, or other features being
> disabled works around your issue, eg:

> # ethtool -K eth0 tx off
> and:
> # ethtool -K eth0 txo off

I tried them, but still the absolut same efect.

ssh mini.glanzmann.de
vim /etc/passwd
=> network card dead

        Thomas
