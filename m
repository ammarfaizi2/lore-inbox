Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbWFUTd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWFUTd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWFUTd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:33:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:10318 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932693AbWFUTd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:33:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S4mifG/xpyRq093Sme4K2+r0YoGWe/9TG7Evn+lghsPIpsLVG7hsZ3W02WMIda8YX83SNYpEtj50CJk7GaoCFOeaArfHewVd0uXqj+CZSEyNsAyZ7Qz9F7cKc2BZfNWSz5hqkJglJkJoH42v0KcQ8PNW1I414i8+uuKFkT0Wkvs=
Message-ID: <9a8748490606211233j442406f4r48917e934e091020@mail.gmail.com>
Date: Wed, 21 Jun 2006 21:33:53 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Herbert Rosmanith" <kernel@wildsau.enemy.org>
Subject: Re: gcc-4.1.1 and kernel-2.4.32
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200606211425.k5LEPtY6012550@wildsau.enemy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.61.0606211615390.31302@yvahk01.tjqt.qr>
	 <200606211425.k5LEPtY6012550@wildsau.enemy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/06, Herbert Rosmanith <kernel@wildsau.enemy.org> wrote:
> a notebook which had problems with our software: a
> "toshiba portege m400". 2.4 seems to work so far, as does 2.6.16.
> I also tried 2.6.17, but get a strange problem: it simply hangs
> after writing "PCI: probing hardware" (or similar). A closer look
> reveals that it hangs in drivers/pci/probe.c, in pci_read_bases. What's
> exactly going on, I don't know...

May I suggest that you write up a complete bug report for that
regression (see the REPORTING-BUGS file for details) and send it to
LKML + Cc: relevant people from MAINTAINERS ?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
