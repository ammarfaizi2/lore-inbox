Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTBGOLb>; Fri, 7 Feb 2003 09:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTBGOLb>; Fri, 7 Feb 2003 09:11:31 -0500
Received: from k101-11.bas1.dbn.dublin.eircom.net ([159.134.101.11]:3346 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S265250AbTBGOLb>;
	Fri, 7 Feb 2003 09:11:31 -0500
Message-ID: <3E43C003.7090602@draigBrady.com>
Date: Fri, 07 Feb 2003 14:17:39 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: c1cc10 <c1cc10@autistici.org>, linux-kernel@vger.kernel.org
Subject: Re: Cyrix III processor and kernel boot problem
References: <3E43C79A.2010506@autistici.org> <20030207141052.GA22687@codemonkey.org.uk>
In-Reply-To: <20030207141052.GA22687@codemonkey.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Feb 07, 2003 at 02:50:02PM +0000, c1cc10 wrote:
>  > I've found out that the Cyrix III has no CMOV instruction and that this 
>  > could be the problem.
>  > So I compiled a pentium mmx version (after mrproper and dep) and all 
>  > worked fine.
>  > My question is: ok, it can't work if 686 compiled, but why does not it 
>  > work also for the Cyrix III version?
> 
> The CyrixIII compile option should not generate cmov.
> If you can objdump -D vmlinuz and grep for cmov, and find out
                         ^^^^^^^ -> vmlinux-2.4.20

> as a sidenote, the new C3s (Nehemiah) now have CMOV.

but no 3dnow so older C3 specific kernels don't work!

Pádraig.

