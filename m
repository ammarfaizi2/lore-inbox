Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSLMJp6>; Fri, 13 Dec 2002 04:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSLMJp6>; Fri, 13 Dec 2002 04:45:58 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:31688
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261742AbSLMJp6>; Fri, 13 Dec 2002 04:45:58 -0500
Subject: Re: atyfb in 2.5.51
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@redhat.com>,
       James Simmons <jsimmons@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.21.0212130949450.6939-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0212130949450.6939-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Dec 2002 10:26:55 +0000
Message-Id: <1039775215.25097.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-13 at 08:53, Geert Uytterhoeven wrote:
> (At first I thought you meant an instruction where the opcode crosses those
>  two memory types, but we don't put code in video RAM...)

I did. The frame buffer drivers support mmap(). x86 has no "non-exec"
bit. So any user able to open /dev/fb can bring down such a box. Similar
things apply with early athlon and prefetching /dev/fb

