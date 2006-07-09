Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWGIOMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWGIOMF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 10:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWGIOMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 10:12:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:21241 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161009AbWGIOME convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 10:12:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:x-operating-system:user-agent:content-transfer-encoding:from;
        b=SG7iuk8chGeonp0BCCX1JaF+W8QEhXR436pR4CC1nzGsXUE2td2XxnIHhBJShb94OLjnALcTuOjO0SSaPlfTm1ymeIh6re/iR7R6jlMqQc7SabVBY6HySLDB+3gkq4aZpqBVIpxd3/Uxcs/4H+Hs7DJZJnQP3FW/z5cXGEfBXWw=
Date: Sun, 9 Jul 2006 16:11:56 +0200
To: Adrian Bunk <bunk@stusta.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: 2.6.18-rc1-mm1 fails on amd64 (smp_call_function_single)
Message-ID: <20060709141156.GB9009@gmail.com>
References: <20060709021106.9310d4d1.akpm@osdl.org> <20060709114925.GA9009@gmail.com> <20060709130027.GG13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20060709130027.GG13938@stusta.de>
X-Operating-System: Linux 2.6.17-mm5
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
From: Gregoire Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 03:00:27PM +0200, Adrian Bunk wrote:

> Thanks for your report, it seems x86_64-mm-getcpu-vsyscall.patch broke 
> COMFIG_SMP=n x86_64 compiles.

Thanks you very much : reverting x86_64-mm-getcpu-vsyscall.patch I can
compil it again :-)
-- 
Grégoire FAVRE  http://gregoire.favre.googlepages.com  http://www.gnupg.org
