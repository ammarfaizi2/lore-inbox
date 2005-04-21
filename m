Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVDUAyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVDUAyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 20:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVDUAyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 20:54:41 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:9715 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261865AbVDUAyk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 20:54:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eLxTM4KY1Z7QE07yQuxKK47hJKvPCZpNmNu58qIhZxkf67TZtLx6G81fE3ommwFbmp9ckrBeO63MSzJlLI5aJSQpGrxefgPJenPwSfhq07iHq1VTXDNRCe9qjKwmZN4tTQmXRA1D+HCd33ilNTa56QyFeKTY3NsNbkVaBHMgE3I=
Message-ID: <21d7e99705042017544407b268@mail.gmail.com>
Date: Thu, 21 Apr 2005 10:54:39 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: 7eggert@gmx.de
Subject: Re: Kernel page table and module text
Cc: Allison <fireflyblue@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E1DOJ92-0002I4-E7@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3V6qt-2ve-9@gated-at.bofh.it>
	 <E1DOJ92-0002I4-E7@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > I want to find where each module is loaded in memory by traversing the
> > module list . Once I have the address and the size of the module, I
> > want to read the bytes in memory of the module and hash it to check
> > it's integrity.
> 
> JFTR: This may work against random memory corruption, but it will fail for
> detecting attacks.

Thats all I use my code for, dumb government regulation says you have
to check for random memory corruption in text segments.. written back
in the old 8-bit controller + EEPROM days ...

Dave.
