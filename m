Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbUANUim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUANUhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:37:50 -0500
Received: from smtp.uniroma2.it ([160.80.6.16]:55821 "EHLO mail-gw.uniroma2.it")
	by vger.kernel.org with ESMTP id S264566AbUANUhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:37:39 -0500
Message-ID: <4005A820.3080801@tiscali.it>
Date: Wed, 14 Jan 2004 21:35:44 +0100
From: Mauro Andreolini <m.andreolini@tiscali.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@users.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: problems with suspend-to-disk (ACPI), 2.6.1-rc2
References: <3FE5F1110001ED59@mail-4.tiscali.it> <20040113131806.GA343@elf.ucw.cz> <20040113212811.GA12144@gateway.milesteg.arr> <400564AD.6050407@tiscali.it> <1074109633.2189.59.camel@laptop-linux>
In-Reply-To: <1074109633.2189.59.camel@laptop-linux>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

>Hi.
>
>I think you'll find that the 'bad: scheduling while atomic' reports are
>completely unrelated to whether the drivers works after suspend or not;
>they simply reflect that drivers_resume is being called with
>preempt_count > 0 (IRQs/preempt not reenabled after copying the image or
>fpu not released).
>
>Regards,
>
>Nigel
>  
>

Thanks for the hint, Nigel. I'll try to take a deeper look into that.

Bye
Mauro Andreolini


