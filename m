Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWEVQXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWEVQXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 12:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWEVQXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 12:23:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:56591 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750950AbWEVQXP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 12:23:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M+w84P21zSiz9qjLx2sj9h4ULcFDMpVEyJ52nSFyWYTrgKoXWjgYWjmA4BllQhIcgeDhKul99k+IvGWPDVGWpOtQaHkfoQ7HK2/2Z1xSBzA4MWN40v7y+OISF3p8LxWdaZsFKkLbigvUAYSmcth5oFwyACnLaVmftOhZP6bktbo=
Message-ID: <625fc13d0605220923l6e6281eap997f7e84b03061b8@mail.gmail.com>
Date: Mon, 22 May 2006 11:23:13 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Martin J. Bligh" <mbligh@google.com>
Subject: Re: 2.6.17-rc4-mm3 - Build error in jffs
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List a" <linux-kernel@vger.kernel.org>,
       "Andy Whitcroft" <apw@shadowen.org>
In-Reply-To: <4471DB32.9060708@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4471DB32.9060708@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/06, Martin J. Bligh <mbligh@google.com> wrote:
> http://test.kernel.org/abat/32863/debug/test.log.0
>
> fs/jffs2/scan.c:530:92: macro "jffs2_sum_scan_sumnode" passed 5
> arguments, but takes just 4
> fs/jffs2/scan.c: In function `jffs2_scan_eraseblock':
> fs/jffs2/scan.c:530: error: `jffs2_sum_scan_sumnode' undeclared (first
> use in this function)
> fs/jffs2/scan.c:530: error: (Each undeclared identifier is reported only
> once
> fs/jffs2/scan.c:530: error: for each function it appears in.)
> make[2]: *** [fs/jffs2/scan.o] Error 1
> make[1]: *** [fs/jffs2] Error 2
> make: *** [fs] Error 2

http://git.infradead.org/?p=mtd-2.6.git;a=commit;h=06c6764b5830798c39617b24497cade90451592f

josh
