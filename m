Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSGSN4N>; Fri, 19 Jul 2002 09:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSGSN4N>; Fri, 19 Jul 2002 09:56:13 -0400
Received: from mnh-1-22.mv.com ([207.22.10.54]:24068 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S316567AbSGSN4N>;
	Fri, 19 Jul 2002 09:56:13 -0400
Message-Id: <200207191502.KAA02022@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] check shm mount succeeded in shmem_file_setup 
In-Reply-To: Your message of "Fri, 19 Jul 2002 17:53:06 +1000."
             <20020719080027.EEA964479@lists.samba.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Jul 2002 10:02:21 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rusty@rustcorp.com.au said:
> And if the initialization fails at boot, we're screwed anyway. 

Why?  If it fails, it still boots fine until something tries using shared
memory.  With UML and my Debian fs, that's Apache, which is the last thing
before the gettys run.

				Jeff

