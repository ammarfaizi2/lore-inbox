Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVFVQGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVFVQGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVFVQFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:05:06 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:17073 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261554AbVFVP7v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:59:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m+MpIA+InhA6MSC2gYZDXZJdkVlAS402Eq+fHRodeJ2AbrjXzSmi04yHR+M3/bxd/ISZepDTNCaNkp2ezdQYatEmbKwQm9ljpBowJFi+kzO0j7BwtUXWm+wyIIoOJQ0yDfgI+naQlwLekxykyNlPY816WJUZmOisA/TKTGEEXlU=
Message-ID: <9a874849050622085975b67c06@mail.gmail.com>
Date: Wed, 22 Jun 2005 17:59:45 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: George Kasica <georgek@netwrx1.com>
Subject: Re: Problem compiling 2.6.12
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0506221026130.4837@eagle.netwrx1.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0506221026130.4837@eagle.netwrx1.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/05, George Kasica <georgek@netwrx1.com> wrote:
> Hello:
> 
> Trying to compile 2.6.12 here and am getting the following error. I am
> currently running 2.4.31 and have upgraded the needed bits per the Change
> document before trying the build:
> 
> [root@eagle src]# cd linux
> [root@eagle linux]# make mrproper
>    CLEAN   .config
> [root@eagle linux]# cp ../config-2.4.31 .config
> [root@eagle linux]# make oldconfig

Don't use a 2.4.x config as the basis for a 2.6.x kernel .
Build your first 2.6.x kernel config using "make menuconfig", "make
config", make xconfig" or similar, /then/ you can use that config in
the future as a base for other 2.6.x kernels with "make oldconfig".

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
