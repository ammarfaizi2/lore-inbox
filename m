Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRJCJS0>; Wed, 3 Oct 2001 05:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271777AbRJCJSP>; Wed, 3 Oct 2001 05:18:15 -0400
Received: from t2.redhat.com ([199.183.24.243]:64507 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S271741AbRJCJSJ>; Wed, 3 Oct 2001 05:18:09 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011003063110.AAA11976@shell.webmaster.com@whenever> 
In-Reply-To: <20011003063110.AAA11976@shell.webmaster.com@whenever> 
To: David Schwartz <davids@webmaster.com>
Cc: kaos@ocs.com.au, Linux-Kernel (E-mail) <linux-kernel@vger.kernel.org>
Subject: Re: Getting system time in kernel.. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Oct 2001 10:18:15 +0100
Message-ID: <30732.1002100695@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davids@webmaster.com said:
> 
> 	2) Making local time offsets tuneable for each case where you need
> one. The  physical location of the machine might or might not be
> meaningful.

Indeed. So you make the GMT offset a mount-time parameter for your 
filesystem, and the question of how to find the current localtime in the 
part of the world where the machine's primary console happens to stick out 
remains meaningless.


--
dwmw2


