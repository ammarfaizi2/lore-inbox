Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVITTWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVITTWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 15:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVITTWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 15:22:09 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:64909 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965092AbVITTWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 15:22:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=LFDYbzViqus3bizFDU8W6ZA5ibNxysMSqc3vDUpGl+Ygb6/fD7FHRYqcu3ttyB7Ez1CBc1GXa1VTT6ExazC3PwajFb8zDxFHnSaytzIlVu2UUXfAWgX+DT3EVNr02LYeuakQHJsO0acVKbdBiWEp4GVR6iQPyPd8MXaANHaHzDU=
Date: Tue, 20 Sep 2005 23:32:35 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Nicolo Chiellini <nchiellini@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on 2.6.12.3
Message-ID: <20050920193235.GA3858@mipter.zuzino.mipt.ru>
References: <BAY106-F33D70574CC7F3E44739F20C8910@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY106-F33D70574CC7F3E44739F20C8910@phx.gbl>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 01:49:08PM +0200, Nicolo Chiellini wrote:
> i've got an oops, but i don't know why, i report the infos in my possession:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000007
> printing eip:
> c01c114b
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in: ohci_hcd ide_scsi rtc
> CPU:    0
> EIP:    0060:[<c01c114b>]    Not tainted VLI
> EFLAGS: 00010287   (2.6.12.3)
> EIP is at cleanup_bitmap_list+0x5b/0xe0

I've filed a bug at kernel bugzilla so your report won't be lost. See
http://bugme.osdl.org/show_bug.cgi?id=5277

Please, register at http://bugme.osdl.org/createaccount.cgi and add
yourself to CC list.

