Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290386AbSBKUzl>; Mon, 11 Feb 2002 15:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290377AbSBKUzc>; Mon, 11 Feb 2002 15:55:32 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:56326 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S290386AbSBKUzV>; Mon, 11 Feb 2002 15:55:21 -0500
Date: Mon, 11 Feb 2002 21:55:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hal Duston <hald@sound.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input w/2.5.3-dj3
Message-ID: <20020211215518.A12817@suse.cz>
In-Reply-To: <Pine.GSO.4.10.10202111430440.12270-100000@sound.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10202111430440.12270-100000@sound.net>; from hald@sound.net on Mon, Feb 11, 2002 at 02:39:47PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 02:39:47PM -0600, Hal Duston wrote:

> I've got CONFIG_INPUT_KEYBDEV=y in my .config so I am assuming yes.
> The keypresses don't generate the correct characters.  I.e. as far as
> I can tell, the 'm' key is Caps Lock, the '9' key is ScrLk, the '0'
> key is NumLk, the 'q' key is 'y', the 'w' key is Ctrl, the 'e' key is 
> 'j' the 'r' key is 'x'.  Etc.  I hope you don't need a complete list!

This is very interesting. Can you pass i8042_direct=1 to the kernel
command line if it fixes anything? Also atkbd_set=3 might help. Anyway,
please send me the log (dmesg) of the bootup in this case. Thanks.
 

-- 
Vojtech Pavlik
SuSE Labs
