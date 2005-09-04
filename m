Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVIDXSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVIDXSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVIDXSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:18:16 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:65193 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751142AbVIDXSP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:18:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qFi6UPKhFm5R5o4RUTzVLmQQzSYgrGADP/YkoG7x0xWBLApwruKfOmHrdqS0ERBEc0g/r9J3QN6fYR8J4fhg16QRHGXsaeGflNtOG+j9geLcXVorcxKEd+lOnYgcVJmPAb1kOioILJSUusEgsbRYu7ty2ekoz3tlk6yDX3NZYHY=
Message-ID: <9a8748490509041618348590ad@mail.gmail.com>
Date: Mon, 5 Sep 2005 01:18:12 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: quiet-non-x86-option-rom-warnings.patch added to -mm tree
Cc: olh@suse.de, mm-commits@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200509042033.j84KXnjx000474@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509042033.j84KXnjx000474@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, akpm@osdl.org <akpm@osdl.org> wrote:
> 
> The patch titled
> 
>      quiet non-x86 option ROM warnings
> 
> has been added to the -mm tree.  Its filename is
[...]
> 
> From: Olaf Hering <olh@suse.de>
> 
> Quiet an incorrect warning in aty128fb and radeonfb about the PCI ROM
> content.  Macs work just find without that signature.
> 
[...]

If everything is fine, then why not just remove the printk() entirely
instead of just changing the level to KERN_DEBUG ?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
