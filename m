Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVFWVmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVFWVmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVFWVil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:38:41 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:53035 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262715AbVFWV32 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:29:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MBsg8ybDGFK3d+j+nfrN7wiOpqpctvz+O2PfHDMiYcthPdxkdL3Qx+2A+okOuw4nvx52ZJYLjSZwbj/WWqIr7dC8Qtxjr++AoV4z6kV0m8a+/rb5cqjAhlbZ0BIMlJ26wrwDV8sqaGfG/cU+pMD4J/J6w1nzOcH2M0dKfQUbRCY=
Message-ID: <3aa654a405062314296a4ca2ae@mail.gmail.com>
Date: Thu, 23 Jun 2005 14:29:21 -0700
From: Avuton Olrich <avuton@gmail.com>
Reply-To: Avuton Olrich <avuton@gmail.com>
To: Adrian Ulrich <reiser4@blinkenlights.ch>
Subject: Re: reiser4 plugins
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, ninja@slaphack.com,
       reiser@namesys.com, jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <20050623221222.33074838.reiser4@blinkenlights.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42BAC304.2060802@slaphack.com>
	 <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
	 <20050623221222.33074838.reiser4@blinkenlights.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/05, Adrian Ulrich <reiser4@blinkenlights.ch> wrote:
> From my POV:
>  I've been using Reiser4 for almost everything (Rootfs / External
>  Harddrives) for about ~8 Months without any data loss..
> 
>  Powerloss, unpluging the Disk while writing, full filesystem,
>  heavy use : No problems with reiser4.. It *is* stable.

*From users who use it* I have heard nothing but love for reiser4.
It's amazing how quickly people seem to be dismissive about what
reiser4 has to offer when they more than likely haven't taken it for a
spin at all. All I hear about is 'we can't let something ugly go into
the stable kernel' then in the same day I looked into some of the
config options...

CONFIG_WDC_ALI15X3:
*snip*
This allows for UltraDMA support for WDC drives that ignore CRC
checking. You are a fool for enabling this option, but there have been
requests.
*snip*

How many have requested that reiser4 make it into the kernel? I'd
imagine many more then requested this IDE feature. And it's an
*option*. Please work something out on this.

avuton

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
