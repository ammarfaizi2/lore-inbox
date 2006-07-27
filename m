Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751874AbWG0Rul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbWG0Rul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWG0Rul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:50:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:61732 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751876AbWG0Ruj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:50:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eOWnn1f2NL+zGo6mscd1/LFVazYdQY3o07xIjeb0mAlUPOZOYyLvpxA0zQ+iSHmZS49C5n794t1Fr6WMH0MFlxC7zZGHYM1J+BQNZy69RIEMFzUyeDB0/Lidrtt6DJpf3MCn4U3x0g8klw8fKr9Tc4TVBM0aDFXpH+X8CLcxcVo=
Message-ID: <a36005b50607271050g7d6fcf59g4950410e7c9356c4@mail.gmail.com>
Date: Thu, 27 Jul 2006 10:50:38 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: O_CAREFUL flag to disable open() side effects
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Pekka J Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       tytso@mit.edu, tigran@veritas.com
In-Reply-To: <44C8F8E3.1070306@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>
	 <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI>
	 <1154021616.13509.68.camel@localhost.localdomain>
	 <44C8F8E3.1070306@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Dumb thought: would it make sense to add an O_CAREFUL flag to open(), to
> disable side effects?

Not that I don't want to be constructive, but this is something you'll
likely never be able to specify with the needed level of accuray.
What is careful?  I can imagine all kinds ideas possible ways file
systems and device drivers might want to use this.

Adding a separate interface taking a file name isn't high enough a
price to open such a can of worms.
