Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275988AbRJBJqI>; Tue, 2 Oct 2001 05:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275987AbRJBJp6>; Tue, 2 Oct 2001 05:45:58 -0400
Received: from t2.redhat.com ([199.183.24.243]:29943 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S275988AbRJBJpp>; Tue, 2 Oct 2001 05:45:45 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <F6E1228667B6D411BAAA00306E00F2A50109C8FC@pdc2.nestec.net> 
In-Reply-To: <F6E1228667B6D411BAAA00306E00F2A50109C8FC@pdc2.nestec.net> 
To: MOHAMMED AZAD <mohammedazad@nestec.net>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Getting system time in kernel.. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Oct 2001 10:43:23 +0100
Message-ID: <3458.1002015803@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mohammedazad@nestec.net said:
>  Any idea how to get the system time in a kernel module.... I tried
> this in solaris... but i am getting only the GMT (that too elapsed
> time) how do i convert this to my locale time....  

You can't. You shouldn't need to convert to localtime inside the kernel. 
What, precisely, are you trying to achieve?

--
dwmw2


