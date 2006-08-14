Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751943AbWHNOvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbWHNOvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWHNOvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:51:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:11785 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751943AbWHNOvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:51:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=E66YV1VfK62ie+jYoSgvpUF4hDiOMWDmM9JPLRF0wTyCw+Lbft7+4B/kxiG3UhPyidhyGTW98Ep2UDyP6eQ0fY0KT+6LYldbkXUZ1h9JDaj4bUjRmwmxzmV1wkIcEg4wgjXlc0073OAC0NdGGvJMxcU7Rc1jt01eekVO7Jvf6qA=
Message-ID: <44E08DEF.4030607@gmail.com>
Date: Mon, 14 Aug 2006 16:51:04 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Hulin Thibaud <hulin.thibaud@wanadoo.fr>
CC: linux-kernel@vger.kernel.org, darkhack@gmail.com
Subject: Re: kernel panic - not syncing: VFS - unable to mount root fs on
 unknown-block
References: <44DFCF20.9030202@wanadoo.fr> <44E07B36.6070508@gmail.com> <44E08C50.5070904@wanadoo.fr>
In-Reply-To: <44E08C50.5070904@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hulin Thibaud wrote:
> Sorry, new kernel is 2.6.17. to install suspend2.
> I believe using LVM, but I'm not sure.

see
/dev/mapper/*

lvm(8) and lvdisplay, vgdisplay, pvdisplay...

mount(8) output

> In effect, initrd is not present ! I rode this lines in my menu.lst :
> title        Ubuntu, kernel 2.6.171915
> root        (hd1,4)
> kernel        /boot/vmlinuz-2.6.171915 root=/dev/hdb5 ro quiet splash
> savedefault
> boot
> 
> So, I suppose that's the center of the problem, but actually, I don't 
> know how to solve it.

You need to run mkinitrd with appropriate parameters on created initrd dir.
See a small howto here:
http://linuxreviews.org/howtos/Kernel-Build-HOWTO/en/x543.html
or use google (and man) to find out howto involve mkinitrd.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
