Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289149AbSA1IVL>; Mon, 28 Jan 2002 03:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289159AbSA1IVB>; Mon, 28 Jan 2002 03:21:01 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:11525 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289149AbSA1IUv>;
	Mon, 28 Jan 2002 03:20:51 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Marian Jancar <jancar@nmskb.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: touch commands in Makefiles 
In-Reply-To: Your message of "Mon, 28 Jan 2002 09:17:27 BST."
             <3C550917.5000500@nmskb.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 Jan 2002 19:20:38 +1100
Message-ID: <4693.1012206038@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002 09:17:27 +0100, 
Marian Jancar <jancar@nmskb.cz> wrote:
>Keith Owens wrote:
>
>>Even easier with kbuild 2.5, it has shadow trees.  You keep the base
>>read only, copy the files to modify to a separate tree and kbuild 2.5
>>logically merges all the files.
>
>Does it allow to compile more kernels each with its own config from one 
>source tree?

Yes, the .config is in the object directory.  You can even compile for
different architectures from the same source tree at the same time.

