Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbUKCJSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbUKCJSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKCJQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:16:48 -0500
Received: from monster.roma2.infn.it ([141.108.255.100]:17070 "EHLO
	monster.roma2.infn.it") by vger.kernel.org with ESMTP
	id S261515AbUKCJPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:15:36 -0500
From: "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
Reply-To: AlberT@SuperAlberT.it
Organization: SuperAlberT.it
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: still no cd/dvd burning as user with 2.6.9
User-Agent: KMail/1.7
References: <41889857.5040506@tequila.co.jp> <20041103084330.GB10434@suse.de> <41889EB5.3060304@tequila.co.jp>
In-Reply-To: <41889EB5.3060304@tequila.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
Date: Wed, 3 Nov 2004 10:15:28 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200411031015.28992.AlberT@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:02, mercoledì 03 novembre 2004, you wrote:
> On 11/03/2004 05:43 PM, Jens Axboe wrote:
> > It should work, are the permissions on your device file correct?
>
> that was the first thing I checked:
>
> gullevek@pluto:~$ ls -l /dev/scd3
> brw-rw----  1 root cdrom 11, 3 2004-04-30 09:28 /dev/scd3
>
> then I thought I am not in the right group:
>
> gullevek@pluto:~$ groups
> users disk cdrom audio operator video staff games
>
> but I am ...
>
> I haven't tried to write a CD, but DVD is definilty not possible,
> because the device is _not_ listed in k3b if started as user. The
> internal CD writer is, so probably I can write here, because before,
> this wasn't even listed ...

I'm running a 2.6.9 vanilla and, as user, my toshiba DVD is correctly listed 
by k3b...  the only thing that sounds strange is an error saying it's 
impossible to determine the supported writeing speed by the device

-- 
<?php echo '       Emiliano `AlberT` Gabrielli       ',"\n",
           '  E-Mail: AlberT_AT_SuperAlberT_it  ',"\n",
           '  Web:    http://SuperAlberT.it  ',"\n",
'  IRC:    #php,#AES azzurra.com ',"\n",'ICQ: 158591185'; ?>
