Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbUKXJvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbUKXJvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUKXJvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:51:06 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:4557 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262581AbUKXJuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:50:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=c40Hhh2UcGzftFc9Y+5WUaVedzhbOYjlnJHuVlAhBHNv4lRjnRONEsWCzDr9MUVryyy3wDn0Oyc6oG0W9hiCDb85k6s9SH+9DHNVkdUDdCIiH40piDQkXOiApLLTxbVxPl9tj750VtgvydWAme9S+F8qefjrhUYHmZ7/0+3KktE=
Message-ID: <b2fa632f04112401504a3f4956@mail.gmail.com>
Date: Wed, 24 Nov 2004 15:20:41 +0530
From: Raj <inguva@gmail.com>
Reply-To: Raj <inguva@gmail.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Delay in unmounting a USB pen drive
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1101288846.15596.5.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <b2fa632f041124012543876b61@mail.gmail.com>
	 <1101288846.15596.5.camel@imp.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can change this by using the "sync" option to mount which will cause
> data to be written synchronously and the umount will be instantaneous.
> Note that this will cause device write to be _much_ slower!
> 

Tried 'mount -o sync /dev/sda /mnt' . After a 57MB file copy, i unmount.  Still
it takes a lot of time.

> One thing is certain, do NOT unplug before the umount completes or you
> will corrupt your fs on the stick for sure.

I shall remember this !. Thx very much. 

-- 
######
raj
######
