Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135457AbRDMJxk>; Fri, 13 Apr 2001 05:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135458AbRDMJxb>; Fri, 13 Apr 2001 05:53:31 -0400
Received: from mailctr.marben.fr ([193.105.113.5]:2057 "EHLO mailctr.marben.fr")
	by vger.kernel.org with ESMTP id <S135457AbRDMJxM>;
	Fri, 13 Apr 2001 05:53:12 -0400
Message-ID: <3AD6CE63.E47CBCA2@atosorigin.com>
Date: Fri, 13 Apr 2001 12:01:07 +0200
From: =?iso-8859-1?Q?S=E9bastien?= GATTI 
	<sebastien.gatti@atosorigin.com>
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: kmem_cache
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have problems with slab management:
While trying to unload a module and destroying cache memory that was
previously allocated
(kmem_cache_destroy routine), I get the following message: "can't free
all objects..."
Then I will get a Oops  if I try to reload the module...
How can I be sure to destroy a cache cleanly?

Thanks for your help
Sebastien


