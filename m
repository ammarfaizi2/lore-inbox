Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbUJWXRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbUJWXRW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 19:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbUJWXRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 19:17:22 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:5735 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261332AbUJWXRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 19:17:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=egPoUn7enpyYhYWcIyBQHqt5/GOQ4uJB1+sIPLjI7BfPHz0azaUla0AkF6CGbK7KGjWI+G3KMMLQC5sWDICLl0pMKJdS6vzYI6ec+0GADbR5Go3lR5Mdn4bk7ATk1EY9E+jIO935Ja9/gTLmGQZu0XEp2rm56eFjE6hHCAIWzUI=
Message-ID: <35fb2e5904102316177420f6a9@mail.gmail.com>
Date: Sun, 24 Oct 2004 00:17:11 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How is user space notified of CPU speed changes?
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <1098571334.29081.21.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098508238.13176.17.camel@krustophenia.net>
	 <1098566366.24804.8.camel@localhost.localdomain>
	 <1098571334.29081.21.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 18:42:13 -0400, Lee Revell <rlrevell@joe-job.com> wrote:

> Does anyone know how OSX/CoreAudio handles the situation?  Apparently
> realtime apps work flawlessly on speed scaling laptops under OSX.

The difference in implementation between the Intel TSC and PowerPC
TB[LU] has been mentioned previously in this thread.

Jon.
