Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbUJYS1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUJYS1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUJYSZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:25:48 -0400
Received: from [195.23.16.24] ([195.23.16.24]:15326 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261198AbUJYSXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:23:39 -0400
Message-ID: <417D44A7.2030904@grupopie.com>
Date: Mon, 25 Oct 2004 19:23:35 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: "Nico Augustijn." <kernel@janestarz.com>, hvr@gnu.org,
       clemens@endorphin.org, linux-kernel@vger.kernel.org
Subject: Re: Cryptoloop patch for builtin default passphrase
References: <200410251354.31226.kernel@janestarz.com> <200410251719.i9PHJmOi009687@turing-police.cc.vt.edu>            <417D38F7.1040204@grupopie.com> <200410251754.i9PHsVrI018284@turing-police.cc.vt.edu>
In-Reply-To: <200410251754.i9PHsVrI018284@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.34; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 25 Oct 2004 18:33:43 BST, Paulo Marques said:
> 
> 
>>I don't have any feelings about this patch, but it seems to me that you 
>>could always store the contents of the nvram somewhere "safe" (you could 
>>even write them down and take it to a safe deposit box in a bank :) ), 
>>and, if those contents happen to change, you could always write them 
>>again...

I really didn't want to pursue this further, but...

> That's assuming that your machine will even *boot* correctly and cleanly if the
> contents of the NVRAM are put back.

You can always boot with a rescue CD or something, assuming that you 
don't have a stupid file system (I think there is none in Linux) that 
mounts even with the wrong magic number and trashes the block device 
contents.

(why would you need confidential information to boot in the first place?)

> And if you're doing the "write it down and type it in again" thing, you might
> as well just use a passphrase, as it's defeating the whole concept of
> using /dev/nvram to xor against....

No it is not. You would just type in again *if* the contents of nvram 
got lost which shouldn't happen in the first place (or at least happen 
rarely).

This is a "just in case" scenario, not a everytime scenario liake the 
passphrase approach.

As I said before, I have no strong feelings about this patch, I just 
don't like to see things defeated over false arguments...

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
