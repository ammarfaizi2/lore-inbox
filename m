Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTLOWeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTLOWeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:34:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:4046 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264127AbTLOWeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:34:21 -0500
From: Christian Borntraeger <kernel@borntraeger.net>
To: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: request: capabilities that allow users to drop privileges further
Date: Mon, 15 Dec 2003 23:34:12 +0100
User-Agent: KMail/1.5.4
References: <20031215213912.GA29281@codeblau.de>
In-Reply-To: <20031215213912.GA29281@codeblau.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312152334.12312.kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:
> I would like to be able to drop capabilities that every normal user has,
> so that network servers can limit the impact of possible future security
> problems further.  For example, I want my non-cgi web server to be able
> to drop the capabilities to
>
>   * fork
>   * execve
>   * ptrace
>   * load kernel modules
>   * mknod
>   * write to the file system

You can have a look at 
http://lsm.immunix.org/ and
http://lsm.immunix.org/lsm_modules.html
if there is something that fits your need. 
If not,  feel free to  write a security module, that is able to do just what 
you want. ;-)

cheers 

Christian

