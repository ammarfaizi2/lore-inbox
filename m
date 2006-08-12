Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWHLOcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWHLOcO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWHLOcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:32:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:47079 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964833AbWHLOcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:32:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nJS4Y6vADczwoxt70KzHiNgHvpL+qUaMayDcvNSJt4GV2PlOF/EokKjFV6f5iHUU2cds4yUwGg3iFMCjbkeMSQhp36PsfDFY/I4J3BDuI7oVunRzL6FKdku/bxWBf/IgmHR/fO4C1sSx3W9LkK6ur5T/+8nYtzc9Jsnx0Z7hNfc=
Message-ID: <81b0412b0608120732i2d583bb8q881eeb914930fa1f@mail.gmail.com>
Date: Sat, 12 Aug 2006 16:32:11 +0200
From: "Alex Riesen" <raa.lkml@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "Sam Ravnborg" <sam@ravnborg.org>, "Paul Mackerras" <paulus@samba.org>
Subject: Re: powerpc: "make install" broken
In-Reply-To: <81b0412b0608120729m42b0c5b5n9f0a06b27796452c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <81b0412b0608120729m42b0c5b5n9f0a06b27796452c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> I don't know if ever worked before, just tried today on v2.6.17.

The error is (retried on 2.6.18-rc4):

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
System.map  2.6.18-rc4; fi
make: *** No rule to make target `install'.  Stop.
make: Leaving directory `/home/raa/v2.6.18'
