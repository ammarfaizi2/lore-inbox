Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVFZQOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVFZQOI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 12:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVFZQOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 12:14:08 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:17162 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261376AbVFZQNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 12:13:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qUMT0VL6Jx7mYkxQJE/RLSBlA7wFWpSzg2dAMYNnbaJDfAL8UlGJYMquRkbo8mWFxbjRvSZ3EhG2nVG+Z1VkZerzADzDhMImH74ROsyXslG7SbYNnZfoMC0j5xlswg9Z3QSunSuIouFw4l1RH9OL1twX9Zxv0PIsYfZe3Ijr96Q=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Alexander Nyberg <alexn@telia.com>
Subject: Re: x86_64 access of some bad address
Date: Sun, 26 Jun 2005 20:19:38 +0400
User-Agent: KMail/1.7.2
Cc: ak@suse.de, linux-kernel@vger.kernel.org
References: <1119539630.1170.6.camel@localhost.localdomain>
In-Reply-To: <1119539630.1170.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506262019.39195.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 June 2005 19:13, Alexander Nyberg wrote:
> As I only have one x86_64 which is my main workstation it's far too
> tedious to do binary searching (this doesn't happen on x86).
> 
> Happens with both latest -git and 2.6.12-mm1
> The tools to reproduce this is at: http://serkiaden.mine.nu/kp2.tar
> 
> Just do:
> gdb lyze
> run
> 
> and it crashes here giving:
> 
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at "mm/memory.c":911

I've filed a bug at kernel bugzilla, so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4801

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.
