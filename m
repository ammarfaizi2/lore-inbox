Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSKMU7O>; Wed, 13 Nov 2002 15:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSKMU7O>; Wed, 13 Nov 2002 15:59:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27405 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263491AbSKMU7N>;
	Wed, 13 Nov 2002 15:59:13 -0500
Message-ID: <3DD2BEBB.8040003@pobox.com>
Date: Wed, 13 Nov 2002 16:06:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: rusty@rustcorp.com.au, kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: Modules in 2.5.47-bk...
References: <76A6C122742@vcnet.vc.cvut.cz>
In-Reply-To: <76A6C122742@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> Hi Rusty,
>   I'm probably missing something important, but do you have any plans
> to integrate module-init-tools into modutils, or extend module-init-tools
> functionality to make them usable? I tried module-init-tools 0.6
> and I must say that I'm really surprised that it is possible to make
> such change after feature freeze, without maintaining at least minimal
> usability.
>
>   If there are modutils which can live with new module system, please
> point me to them. But I did not found such.


I'm hoping that Rusty will work with Keith to integrate support for 
2.5.x into the existing modutils package...  it's rather annoying to 
have two totally different modutils when switching between 2.[024].x and 
2.5.x kernels.

/me is building drivers into the kernel for now, which slows down 
debugging, because modules are broken on ia32 and module support isn't 
present on alpha at all anymore [AFAICS]...

