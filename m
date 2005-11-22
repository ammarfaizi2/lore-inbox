Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVKVA3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVKVA3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVKVA3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:29:35 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:63420 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964801AbVKVA3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:29:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oWTekE2MQV/nkGpYBAw8tH089AlGu3eLqgiOdQ9EuFPi1r6TshafKKxNtXmPPZbn9OP2iB+oIgZHDf5uI1sB9R8KJ3ifc5nQQK2jY4eVx1/nDax2qkYce2W3ZC5ZzLwuQP3OU1e6wh7mBXBUfSemRugH2OphHB/QgitygnPp8VY=
Message-ID: <43826648.9030606@gmail.com>
Date: Tue, 22 Nov 2005 08:28:56 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Damien Wyart <damien.wyart@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VESA fb console in 2.6.15
References: <20051121215531.GA3429@localhost.localdomain>
In-Reply-To: <20051121215531.GA3429@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damien Wyart wrote:
> Hello,
> 
> I've noticed in several versions of 2.6.15 that VESA fb console seems
> completely broken : it draws screen in several very slow steps, making
> the whole display almos unusable. And it crashes *very* often, for
> example when switching to X. The computer is complety locked, and
> doesn't even respond to SysRQ.
> 
> I guess it is quite trivial to reproduce, the difference with 2.6.14 is
> immediately visible.
> 
> I use vga=0x31B as boot param.
> 

Try booting with:

vga=0x31b video=vesafb:mtrr:3

or

vga=0x31b video=vesafb:ypan,mtrr:3

Tony

