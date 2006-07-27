Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751899AbWG0R4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWG0R4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWG0R4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:56:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55256 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751899AbWG0R4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:56:34 -0400
Message-ID: <44C8FE41.5040909@garzik.org>
Date: Thu, 27 Jul 2006 13:56:17 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Hans Reiser <reiser@namesys.com>, Matthias Andree <matthias.andree@gmx.de>,
       lkml@lpbproductions.com, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com> <44C44622.9050504@namesys.com> <20060724085455.GD24299@merlin.emma.line.org> <44C4813E.2030907@namesys.com> <20060726131709.GB5270@ucw.cz>
In-Reply-To: <20060726131709.GB5270@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>> of the story for me. There's nothing wrong about focusing on newer code,
>>> but the old code needs to be cared for, too, to fix remaining issues
>>> such as the "can only have N files with the same hash value". 
>>>
>> Requires a disk format change, in a filesystem without plugins, to fix it.
> 
> Well, too bad, if reiser3 is so broken it needs on-disk-format-change,
> then I guess doing that change is the right thing to do...

Actually, there is reiser4 brokenness lurking in Hans' statement, too:

A filesystem WITH plugins must still handle the standard Linux 
compatibility stuff that other filesystems handle.

Plugins --do not-- mean that you can just change the filesystem format 
willy-nilly, with zero impact.

	Jeff



