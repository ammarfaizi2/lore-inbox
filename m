Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWKQMus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWKQMus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 07:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932887AbWKQMus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 07:50:48 -0500
Received: from web23102.mail.ird.yahoo.com ([217.146.189.42]:11930 "HELO
	web23102.mail.ird.yahoo.com") by vger.kernel.org with SMTP
	id S932107AbWKQMus convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 07:50:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ot67+DjIwApHrB9cDlWyomAJfohAP/228MZK0o728WM/UrSsTg2QW9TqImKYqlz2u36Jdb4hjIy6Pgne4zblYAgnMHcZKfhv+Enfr9Cin9iQ50MgPtHb9dLkwQyCM9Gjp5mZbqTYVa8zoj+Z2b1BUIZ2SRX9JV/lT4XWZqi9qwo=  ;
Message-ID: <20061117125046.22496.qmail@web23102.mail.ird.yahoo.com>
Date: Fri, 17 Nov 2006 12:50:46 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : vm: weird behaviour when munmapping
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> 
> http://lwn.net/Kernel/LDD3/
> 
> Chapter 15. Section 'Virtual Memory Areas'.
> 
> Basically; vm_ops->open() is not called on the first vma. With this
> munmap() you split the area in two, and it so happens the new vma is the
> lower one.
> 

since I did "munmap(0x2aaae000, 1024)" I would say that the the new vma
is the _upper_ one.

lower vma: 0x2aaae000 -> 0x2aaaf000
upper vma: 0x2aaaf000 -> 0x2aab2000

Francis







	

	
		
___________________________________________________________________________ 
Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! 
Profitez des connaissances, des opinions et des expériences des internautes sur Yahoo! Questions/Réponses 
http://fr.answers.yahoo.com
