Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWHNOw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWHNOw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWHNOw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:52:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:7824 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932358AbWHNOw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:52:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q2s6QwVqjUr3WlkM2TO3daPR4MToSBJOzQxx3Oogx7zrTO7DgpRSLoNHPYxALVCIzdPihNipg7yt67TIg8DaUkIGIYQjKrJ9mKFyTaHenohLqkBaZVSP6/+bxyaywanwXa4Xlqt9Tz+RaUH9DoIWaoCntn5Vy50wgBFw97HoMWs=
Message-ID: <4a5881460608140752t1e1f7157xaff450e2f16d7f9@mail.gmail.com>
Date: Mon, 14 Aug 2006 11:52:57 -0300
From: "Reinaldo Carvalho" <reinaldoc@gmail.com>
To: "Hulin Thibaud" <hulin.thibaud@wanadoo.fr>
Subject: Re: kernel panic - not syncing: VFS - unable to mount root fs on unknown-block
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44E08C50.5070904@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44DFCF20.9030202@wanadoo.fr> <44E07B36.6070508@gmail.com>
	 <44E08C50.5070904@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try build-in LVM driver.

Device Drivers  --->
Multi-device support (RAID and LVM)  --->
[*] Multiple devices driver support (RAID and LVM)
[*]   Device mapper support

-- 
Reinaldo Carvalho


On 8/14/06, Hulin Thibaud <hulin.thibaud@wanadoo.fr> wrote:
> Sorry, new kernel is 2.6.17. to install suspend2.
> I believe using LVM, but I'm not sure.
> In effect, initrd is not present ! I rode this lines in my menu.lst :
> title           Ubuntu, kernel 2.6.171915
> root            (hd1,4)
> kernel          /boot/vmlinuz-2.6.171915 root=/dev/hdb5 ro quiet splash
> savedefault
> boot
>
> So, I suppose that's the center of the problem, but actually, I don't
> know how to solve it.
>
