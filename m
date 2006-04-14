Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWDNBBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWDNBBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 21:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWDNBBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 21:01:23 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:53753 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965083AbWDNBBX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 21:01:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BxI0ILZMPjUWTH3X2B9KVOg/n9of9qUup0wgNMxQv0yYdQBu86WXOj0HYi0QUia3lYPZT9kkLzMXGE1DhYCukhX2Q7oLp2+fWnGZwfTi9ywOkyhOZk305omDvFoiZiZTO3bF6uZRMhdjQ/PyowrLlOAGDID5iH4uA9YekBPKGuE=
Message-ID: <aec7e5c30604131801t6cfd4cefmb0be8b78982cbee7@mail.gmail.com>
Date: Fri, 14 Apr 2006 10:01:22 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [PATCH] Kexec: Remove order
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Magnus Damm" <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604131252110.14044@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060413030040.20516.9231.sendpatchset@cherry.local>
	 <m164le6rcg.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.64.0604131252110.14044@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Wed, 12 Apr 2006, Eric W. Biederman wrote:
>
> > Until I see a reasonable argument that none of the architectures
> > currently supported by the linux kernel would need a multi order
> > allocation for a kexec port am I interested in removing support.
>
> IA64 needs an order 1 allocation for stack / task_struct.

Ok, but is it needed to kexec another kernel?

/ magnus
