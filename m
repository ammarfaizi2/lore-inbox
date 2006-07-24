Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWGXMDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWGXMDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 08:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWGXMDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 08:03:48 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:37900 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S932123AbWGXMDr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 08:03:47 -0400
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: linux-kernel@vger.kernel.org
Subject: Re: Can't clone Linus tree
Date: Mon, 24 Jul 2006 14:03:45 +0200
User-Agent: KMail/1.9.1
References: <20060724080752.GA8716@irc.pl>
In-Reply-To: <20060724080752.GA8716@irc.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607241403.45177.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witam, 

>  yesterdat I wanted to bisect my kernel problem, but failed at first step:
> cloning Linus' tree. Today I tried it on other system and also failed.
>

[cut]

>
>  Errors occur constantly since yesterday. They of course appear after
> downloading several megabytes of data, which is unpleasant on my 128kbps
> connection.

I saw that as well many times with both git vesrion 1.2.4 and 1.4.1:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
linux-2.6
Generating pack...
Done counting 293611 objects.
Deltifying 293611 objects.
 100% (293611/293611) done
fatal: unexpected EOF)      
fatal: packfile '/home/me/linux/linux-2.6/.git/objects/pack/tmp-FtdxDS' SHA1 
mismatch
error: git-fetch-pack: unable to read from git-index-pack
error: git-index-pack died with error code 128
fetch-pack from 
'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' 
failed.

Each time it fails after downloading approx. 60MB of data. Reported to vger 
git list with no response.

Regards,

	Mariusz Koz³owski
