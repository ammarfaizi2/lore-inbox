Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVDYIon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVDYIon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 04:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVDYIon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 04:44:43 -0400
Received: from [62.206.217.67] ([62.206.217.67]:4838 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262488AbVDYIol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 04:44:41 -0400
Message-ID: <426CADF1.2000100@trash.net>
Date: Mon, 25 Apr 2005 10:44:33 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: Alexander Nyberg <alexn@dsv.su.se>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
References: <200504240008.35435.kernel-stuff@comcast.net> <1114332119.916.1.camel@localhost.localdomain> <200504240903.31377.tomlins@cam.org>
In-Reply-To: <200504240903.31377.tomlins@cam.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> I think rc3 has code from rc2-mm2/3.  Both of these reboot here randomly.  Nothing
> shows up on a serial console...  Think something is seriously wrong with x86_64 in rc3.
> That being said its possible its fixed in HEAD by.
> 
> [PATCH] x86_64: fix new out of line put_user()
> [PATCH] x86_64: Bug in new out of line put_user()

I'm seeing the same problem with a fresh git checkout when running uml
or gcc in 32bit mode. Nothing is received from netconsole. If anyone
can suggest which patches might be worth reverting I'll try that.

Regards
Patrick
