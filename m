Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWFKWyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWFKWyw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 18:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWFKWyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 18:54:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:18574 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750739AbWFKWyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 18:54:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ozwhJ2xGbq1ztbTeFm4JNilVKSnPrgQ5YXqO2cgng+P5hESy9ZbGCk2PNh6GALvQ73xmv7+gkQpYXbGk+G1X4iXQhuMYq/Ezbn4cUQ03Eq5IBnXN5sCuoHmm5GSzgLGSXye0/X4OK7rRBWs0EusTTM7tbI2mlo5vDJCxB4gdLng=
Message-ID: <9a8748490606111554s6f6b9e22uce4dc765dc6841d2@mail.gmail.com>
Date: Mon, 12 Jun 2006 00:54:50 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Matt Mackall" <mpm@selenic.com>
Subject: Re: [PATCH] x86 built-in command line
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20060611215530.GH24227@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611215530.GH24227@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/06, Matt Mackall <mpm@selenic.com> wrote:
[snip]
> +config CMDLINE
> +       string "Initial kernel command string" if EMBEDDED
> +       depends on CMDLINE_BOOL
> +       default "root=/dev/hda1 ro"
> +       help
> +         On some systems, there is no way for the boot loader to pass
> +         arguments to the kernel. For these platforms, you can supply
> +         some command-line options at build time by entering them
> +         here. In most cases you will need to specify the root device
> +         here.

Perhaps "In most cases you will need to specify at least the root
device here." ???

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
