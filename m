Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUKRUYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUKRUYh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUKRUYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:24:30 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:62700 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262974AbUKRUXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:23:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=s6Wao8XDK+d80Y5MSGbhaK1bra6ctWjbx9rKxtjI1CT+B6wpxARZyTVRuCz8iZHCOCl7Mzl2OMKXDmcVGhnXDhitVNyP/5vUe0ypdSAcj5UBMCnuvekuwoTeX9D1ikqwBqJOlzV6NUswjiCORRi9+1tWSWVw/4kdjNLYSn676JM=
Message-ID: <69304d1104111812234656a606@mail.gmail.com>
Date: Thu, 18 Nov 2004 21:23:13 +0100
From: Antonio Vargas <windenntw@gmail.com>
Reply-To: Antonio Vargas <windenntw@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PATCH: Altivec support for RAID-6
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <419C46C7.4080206@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <419C46C7.4080206@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004 22:52:55 -0800, H. Peter Anvin <hpa@zytor.com> wrote:
> This patch adds Altivec support for RAID-6, if appropriately configured
> on the ppc or ppc64 architectures.  Note that it changes the compile
> flags for ppc64 in order to handle -maltivec correctly; this change was
> vetted on the ppc64 mailing list and OK'd by paulus.
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> 

hpa, are you aware of any other routines which should benefit from altivec?

-- 
Greetz, Antonio Vargas aka winden of network

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
