Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVFLPbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVFLPbX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVFLPbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:31:23 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:26200 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262622AbVFLPbJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:31:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kiaRj2xyRgMe6XYEOARBxIUpoYFqPtpXxe2fw3gaUzeR/3m04RRPUPRzZIor4cq/gsNhurFJdW5ltRNjTFskcArvPnfP+8aBxmkdXyeFN+R6cwJH8lB41wZgIUhJOyrrcUAdG7YjGBEju6DUukq/ZdwzF0zgmDdpBTN+wG7oPKQ=
Message-ID: <fe726f4e05061208312e871a8b@mail.gmail.com>
Date: Sun, 12 Jun 2005 17:31:05 +0200
From: Carlos Martin <carlosmn@gmail.com>
Reply-To: Carlos Martin <carlosmn@gmail.com>
To: li nux <lnxluv@yahoo.com>
Subject: Re: 2.6: problem with module tainting the kernel
Cc: randy_dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050612092544.25913.qmail@web33308.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050610201812.037b6a01.rdunlap@xenotime.net>
	 <20050612092544.25913.qmail@web33308.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/05, li nux <lnxluv@yahoo.com> wrote:
> Thanks to Randy and everyone who replied.
> Yes, I am using SuSE kernel.
> On building the module it successfully generates
> hello.ko.
> Here is the message I get on doing a insmod of
> hello.ko:
> 
> "Jun 12 14:47:56 myhost kernel: hello: unsupported
> module, tainting kernel."
 This means that the module is unsupported by SuSE/Novell and
therefore vendor-tainted. It does not mean that the kernel is tainted
in the canonical way. IIRC there are different types of tainting, and
this is just one of them.

-- 
Carlos Martín         http://www.cmartin.tk   http://rpgscript.berlios.de

Nowadays everyting has infrared and wireless. If it's big enough, it
gets Gigabit and a DVD burner.
