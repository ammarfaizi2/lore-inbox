Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVCWKk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVCWKk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVCWKk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:40:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:48584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261523AbVCWKjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:39:37 -0500
Date: Wed, 23 Mar 2005 02:38:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: Samsung 40G drive locking up 2.6.11
Message-Id: <20050323023853.28c9a432.akpm@osdl.org>
In-Reply-To: <200503221431.31549.vda@ilport.com.ua>
References: <200503221431.31549.vda@ilport.com.ua>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>
> dd if=/dev/hdc of=/dev/null with this disk
>  kills the system. Drive may do it's work
>  for minute or two, but then it does 'klak' sound.
>  With udma5 (default) Linux froze solid, no SysRq key, nothing.
>  Powercycling helps.
> 
>  With udma3, it did not die, but still spews IDE errors.
>  I will try to collect more data points.

Did it work OK under earlier kernels?  If so, which?
