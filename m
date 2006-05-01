Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWEAUaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWEAUaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWEAUav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:30:51 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:41141 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932230AbWEAUav convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:30:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eN9B4v8nGoQKrUaWW3pVM+OzB0LwpZS8RdAGL08ehMePOYMlO2YsCdOfbVFAbiCGtRa4E9fKUi/jO/aiWs4oirPrzCl614S94wNlp5I0UPoGdkuVR2efu67uNUrTg3V/t6KqWh+hhCyOY1k4vOpjpVmDyvvgbzCDFfyWZoy081w=
Message-ID: <bda6d13a0605011330v6449d698t86390dd9aa97162d@mail.gmail.com>
Date: Mon, 1 May 2006 13:30:50 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] minix filesystem update to V3 diffed to 2.6.17-rc3
In-Reply-To: <44564B34.6020109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <44560796.8010700@gmail.com>
	 <20060501100328.37527eb2.akpm@osdl.org> <4456430C.2040806@gmail.com>
	 <44564B34.6020109@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/06, Jiri Slaby <jirislaby@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Daniel Aragonés napsal(a):
> > Hi Andrew,
> >
> > Well, I don't know how to solve it. If I don't allocate with kmalloc,
> > the compiler stops with error. If I free memory with kfree instead of
> > setting offset = NULL, an exception is produced.
> Ok, which error?

Is this the error about variable might not be initalized?
What happends in the code if you just initalize to NULL?
