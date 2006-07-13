Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWGMJn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWGMJn1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWGMJn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:43:26 -0400
Received: from web26905.mail.ukl.yahoo.com ([217.146.176.94]:11404 "HELO
	web26905.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964875AbWGMJn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:43:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=W96sDlmQYCZFavdxerNIK6tfZUCq3qpQY6iVauJooJmIrhcj6W+A8hwVAZtQmgV4y9HU5A8yf1Y5g/ryta/6Pv0IV6ir4yu3oneVJtXLgcKW49wZ8+H3hLcRZFeXPPdOqy/qunKr2qk/yINYEsjJ18SDIq5fNqa6sXMtQJcOSwA=  ;
Message-ID: <20060713094325.87127.qmail@web26905.mail.ukl.yahoo.com>
Date: Thu, 13 Jul 2006 11:43:25 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: 2.6.18-rc1-mm1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Error while compiling:
  CC      kernel/uid16.o
  CC      kernel/kallsyms.o
kernel/kallsyms.c: In function ‘get_ksymbol_mod’:
kernel/kallsyms.c:279: error: too many arguments to function ‘module_get_kallsym’
make[1]: *** [kernel/kallsyms.o] Error 1
make: *** [kernel] Error 2

  With a .config containing:
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set

 Fixed by removing CONFIG_KALLSYMS.
 Using my usual monolitic kernel (no modules) if it has a relation at all.

 Cheers,
 Etienne.


	

	
		
___________________________________________________________________________ 
Yahoo! Mail réinvente le mail ! Découvrez le nouveau Yahoo! Mail et son interface révolutionnaire.
http://fr.mail.yahoo.com
