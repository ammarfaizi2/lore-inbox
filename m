Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTLLTTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTLLTTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:19:44 -0500
Received: from imag.imag.fr ([129.88.30.1]:21936 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261825AbTLLTTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:19:41 -0500
Date: Fri, 12 Dec 2003 20:16:06 +0100
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: PCI lib for 2.4
From: =?ISO-8859-1?Q?Damien_Courouss=E9?= <damien.courousse@imag.fr>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A2ABB06A-2CD7-11D8-8839-00039344321E@imag.fr>
X-Mailer: Apple Mail (2.482)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm a rookie in Linux development, and I have to develop a small driver 
for a data-acquisition card on PCI port.

My problem is that my compiler does not recognize some functions such as 
'pci_resource_start()', or 'pci_find_device()' ...

I used option  'gcc [...] -lpci' in order to link with pci lib, but 
that's not better. It seems that I have many different versions of the  
pci.h file : /usr/src/linux2.4.18-14/include/linux/pci/h is much bigger 
and much more complete, and more interesting (or it seems to be) than my 
/usr/include/linux/pci.h one, or even /usr/include/driver/pci/pci.h one.

If I do a 'locate pci.a', and then a 'grep pci_resource 
filed-returned-by-locate', I do not have anything. That could mean the 
functions I look for do not exist in my lib.

What do I have to do if I wan't to use the .../src/linux2.4.18... one?

Thanks for any help.

Please tell me if linux-kernel list does not directly concern my problem 
or if there others that fit better.

Damien

