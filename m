Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVJBSxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVJBSxQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 14:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVJBSxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 14:53:16 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:3565 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751142AbVJBSxQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 14:53:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dQKPn+JWIhq+gmefuYoaEuzS4vzv1hK27I0G7MtHO3GZXKeF8NWHImewPmS1Vqv+4WYIAtoCz/MyZWL1mwoZmzSiCma4xTJhwjOXczkDx9MuU4jajO+tuphIxKPD30YLjCV0y++y+XH7ffawy6d/tjBfKQ1m8TJT5PFQ4HbiWaw=
Message-ID: <35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com>
Date: Sun, 2 Oct 2005 19:53:15 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Why no XML in the Kernel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051002094142.65022.qmail@web51012.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/05, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com> wrote:

> Can somebody tell me why the Kernel-Development dont
> wanne have XML is being used in the Kernel??

I think it's mostly because the marketeers haven't got to everyone yet
:-) The kernel might be e-enabled, but it's not fully
iBuzzwordcompliant.

Besides, having a *fully* XML parser/generator in the kernel is
extremely braindead, even if it's called libkernelxml ("I'm not really
quite in the kernel really") or something. What's so wrong with really
simple files being exposed to userspace? Most of these are less than a
single page of data and it's just dandy like that.

Jon.
