Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWEDUtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWEDUtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 16:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWEDUtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 16:49:01 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:36193 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030324AbWEDUtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 16:49:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OWIM4ZX/4vEmSaxCFUQA7aWplCyDKlmFql66vRvkWGy2KCXU2QAiZxzG+c+57EmlXtb3XUOLLcm5W7976rXQwtBD/L4nf+K1kWbDamof8z8NQ84g6pmW6J+0uT4++yazGv2efZcwPUNMcXTvig0HEf9jxpNn9uzMh+kcmDCON9Y=
Message-ID: <445A68AC.3090207@gmail.com>
Date: Fri, 05 May 2006 04:48:44 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Giuseppe Bilotta <bilotta78@hotpop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: framebuffer broken in 2.6.16.x and 2.6.17-rc3 ?
References: <60f2b0dc0605021251i1c883617vf132e8bdeffd6c7f@mail.gmail.com> <gs7iuaocrzmp.s33e3qhm21bl.dlg@40tude.net>
In-Reply-To: <gs7iuaocrzmp.s33e3qhm21bl.dlg@40tude.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
> On Tue, 2 May 2006 21:51:13 +0200, Olivier Fourdan wrote:
> 
>> I'm surprised noone has raised that issue yet, so I'm wondering if I'm
>> missing something obvious :) When using the fb in 2.6.16.x and
>> 2.6.17-rc3, the screen stays just black, nothing is displayed... I'm
>> using the regular unaccelerated vesa framebuffer.
> 
> It may sound silly and it's probably not relevant to your case, but I
> had this kind of result during a kernel upgrade some versions ago when
> I forgot the fbcon module.
> 

Not silly because that is exactly what happened. He sent me his config in a
private mail.

I don't know what method he used to upgrade his kernel, but the setting
changed from 'y' to 'm', and I've received quite a few reports from
different users on this lately...

Tony
