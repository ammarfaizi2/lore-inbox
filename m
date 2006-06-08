Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWFHWje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWFHWje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 18:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWFHWje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 18:39:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:33904 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964996AbWFHWjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 18:39:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uYZBAGSpyivXv4LqAWUw+6Hd60j14MgJJ4gY7Akwbbpe2xvlbrME1a9TU7Am1EA0cjqphvLKnpj4fa4zSwvsvkrznVbetzFPgVqwLYUbP7ARvIpvvAXnajS+f0VM+LwPvhzT0DY7kxXkfiudVWA+4fO7NroAkG1O1JfIyPKrz9I=
Message-ID: <bda6d13a0606081539h1f240acbrf97ea5a47925e701@mail.gmail.com>
Date: Thu, 8 Jun 2006 15:39:33 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Idea about a disc backed ram filesystem
In-Reply-To: <200606082151.k58LpTq7007519@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Sash_lkl@linuxhowtos.org>
	 <200606082233.13720.Sash_lkl@linuxhowtos.org>
	 <200606082151.k58LpTq7007519@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just *screams* block-layer. If anybody feels up to it,
try making a modified loopback device that implements
an independent, fixed-size write-through cache using vmalloc and such.

I have a hunch it won't really improve performance much.
