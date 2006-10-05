Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWJEL2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWJEL2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 07:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWJEL2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 07:28:01 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:49581 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750782AbWJEL2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 07:28:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b0e9qAG9hCgOt0/QklhfoD5HWsH1NMFgs4tlHvwujEZr4nFXqxU0r6SefJLT7rmlDSsqDNIytxOhnLhTHoyoKmB7R9XGle8cKBivwRok+K0NuJd7vuEd9aUKzMP38cMtf0t1GCpk0fRxYRJfdp2c+WPeaJY0wznAOoqiH3zDyqA=
Message-ID: <9a8748490610050428kc87fd6aj9b18d6e51e64f145@mail.gmail.com>
Date: Thu, 5 Oct 2006 13:28:00 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Lukas Hejtmanek" <xhejtman@mail.muni.cz>
Subject: Re: Machine reboot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061005105250.GI2923@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061005105250.GI2923@mail.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/06, Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> Hello,
>
> I'm facing troubles with machine restart. While sysrq-b restarts machine, reboot
> command does not. Using printk I found that kernel does not hang and issues
> reset properly but BIOS does not initiate boot sequence. Is there something
> I could do?
>
You can try playing with different combinations of these options :

CONFIG_APM_ALLOW_INTS
CONFIG_APM_REAL_MODE_POWER_OFF

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
