Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264969AbTLFIvp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 03:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbTLFIvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 03:51:45 -0500
Received: from stinkfoot.org ([65.75.25.34]:41615 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S264969AbTLFIvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 03:51:43 -0500
Message-ID: <3FD1994C.10607@stinkfoot.org>
Date: Sat, 06 Dec 2003 03:54:36 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tero Knuutila <tero1001@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
References: <Law9-F31u8ohMschTC00001183f@hotmail.com> <Pine.LNX.4.58.0312060011130.2092@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312060011130.2092@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 6 Dec 2003, Tero Knuutila wrote:
> 
>>My system hangs everytime I try to  burn my .wav files to cd with cdrecord.
>>Usually few tracks go succesfully but then everything stops. Even the mouse
>>won't move and powerbutton does not affect.
> 
> 
> Is this with ide-scsi? If so, does the appended patch help?
> 
> If not, we really need a whole lot more information (hw config, messages
> etc).
> 
> 		Linus

I've noted this at boot several times with 2.6.0-test11

Dec  4 23:59:21 e-d0uble kernel: ide-scsi is deprecated for cd burning! 
Use ide-cd and give dev=/dev/hdX as device

Removing the ide-cd bootparams: (I didn't try the patch)

Cdrecord 2.00.3 seems to like the sony-dru500a, denoted as 
--dev=/dev/hdc, I burned several disks this way.
crdao and growisofs don't like to parse /dev/hdc as an argumenet, but 
I'm sure these are easily fixed.

Ethan
