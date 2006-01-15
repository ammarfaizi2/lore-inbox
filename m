Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWAOFS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWAOFS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 00:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWAOFS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 00:18:59 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:5585 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751114AbWAOFS6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 00:18:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hwru7AirxyD+5o57InYfouoXyiIJ/SHdATnrcUtM42j1FGmGklqgulUZpnrU4clRP+zyXmJh3ej/5YVddv3pjTkRUOQT6JYalQtvfndg8KLyManHYz7b8K353wG2WE45Eq2ume/uksY4xuJKhftxpU8TqONyhnEkk3ciO4tq9Z0=
Message-ID: <a36005b50601142118h3a07a640ra668dab13129683b@mail.gmail.com>
Date: Sat, 14 Jan 2006 21:18:57 -0800
From: Ulrich Drepper <drepper@gmail.com>
To: david singleton <dsingleton@mvista.com>
Subject: Re: [robust-futex-1] futex: robust futex support
Cc: akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <746DBAD6-855A-11DA-A824-000A959BB91E@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43C84D4B.70407@mvista.com>
	 <a36005b50601141602y641567ebh5ff9b6a1fad4d7d2@mail.gmail.com>
	 <746DBAD6-855A-11DA-A824-000A959BB91E@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/06, david singleton <dsingleton@mvista.com> wrote:
> can you suggest some error codes you like to use?  I'll use
> whatever you suggest.

How about EADDRNOTAVAIL.  The error message kind of makes sense, even
though "address" is misused.  And there definitely won't be a clash
with other error codes because it's currently only used in network
contexts.
