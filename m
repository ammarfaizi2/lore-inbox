Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVIEQNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVIEQNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVIEQNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:13:18 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:22613 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932222AbVIEQNS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:13:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T8uFUEULDwqxDEquaYa5KuPj4IboxiB0yeJF5HoupNnpzzcV4QJECeGmOg25zTjhPkoVLZ9S7NF3PJqAxitxqZfbm8rhadAEExVYrKQHLZoHmpzOMndPQWJez3xeJdt6mReCCgLY81S3w4CrMP0cdEkguO6OIwQaxHScme2iXhA=
Message-ID: <9a874849050905091364b6a103@mail.gmail.com>
Date: Mon, 5 Sep 2005 18:13:15 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: hanasaki <hanasaki@hanaden.com>
Subject: Re: kernel 2.6.13 hangs / freezes with nvidia kernel module on switch to virtual console (also 2.6.12)
Cc: LIST - Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <431C6C0A.4080302@hanaden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <431C6C0A.4080302@hanaden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, hanasaki <hanasaki@hanaden.com> wrote:
> kernel 2.6.13 hangs / freezes with nvidia
> kernel module on switch to virtual console
> 
> Running Debian testing and stable and built the kernel with the attached
> config.  Then the NVidia installer was run.  Everything boots and runs
> fine.  X and Gnome come up and run.  Switching to a Virtual Console
> locks up the system and shows some crazy colors.
> 
> The system ran fine with the same configs until ~kernel 2.6.12.x and has
> exhibited this failing behavior since then with multiple kernels.
> 
> The graphics card is a shown below and has two outputs both in use for
> two monitors.  Thus the actual driver from NV is needed.  I do not
> believe the Xfree nv driver supports dual head.
> 
> ======================
> NVidia version
> NVIDIA-Linux-x86-1.0-7676-pkg1.run <= from nvidia.com
> 

Reproduce the problem without a binary only kernel module. Or in this
case, complain to nvidia.

It's impossible for kernel developers to debug a problem involving a
closed source module. The authors of that module will have to do the
fixing.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
