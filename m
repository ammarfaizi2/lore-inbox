Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131941AbQLHXZu>; Fri, 8 Dec 2000 18:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132075AbQLHXZl>; Fri, 8 Dec 2000 18:25:41 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:46856 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131941AbQLHXZ2>;
	Fri, 8 Dec 2000 18:25:28 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: jna@microflex.ca
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops 2.2.17 
In-Reply-To: Your message of "Fri, 08 Dec 2000 14:14:31 CDT."
             <001d01c0614b$1886c1e0$a11410ac@microflex.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Dec 2000 09:54:55 +1100
Message-ID: <5167.976316095@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000 14:14:31 -0500, 
"Jean-Francois Nadeau" <jna@microflex.ca> wrote:
>Dec  7 17:01:54 trinity kernel: EIP:
>0010:[update_vm_cache_conditional+138/328]

You are letting klogd convert the oops, it is broken.  Change klogd to
run with "klogd -x", reproduce the oops and get a clean decode with
ksymoops.

>Warning: trailing garbage ignored on Code: line
>  Text: 'Code: 39 59 08 75 e1 8b 5c 24 20 39 59 0c 75 d8 ff 41 14 b8 02 00
>'
>  Garbage: '  '

Looks like an old ksymoops, current is 2.3.5, from
ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.3

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
