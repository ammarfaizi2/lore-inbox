Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVJ2NKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVJ2NKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 09:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbVJ2NKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 09:10:04 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:33969 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750802AbVJ2NKD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 09:10:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W35Nfc1tCIpZvcuQy/Am5uRKPeBw4MTTf1nVhIwdlJOMUsNszH0C8Wj+Kvjf9zP4I0g86SsRiEGcUOlMeU92GQ/BWc9Rd6ZZJFyWEGCyMXreqLVmUcCq0MLqwd8uxGjup8pSLiUQGR4DcebThcAO48pjQsUm23KWQQR9Am9lmQA=
Message-ID: <35fb2e590510290610w6619afcoe10662f1e4a290c5@mail.gmail.com>
Date: Sat, 29 Oct 2005 14:10:02 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <35fb2e590510290458u47ad70d2s1f5956cb47c193c0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4360C0A7.4050708@weizmann.ac.il>
	 <35fb2e590510270805h1739b19chf0b719948aa6f4f@mail.gmail.com>
	 <35fb2e590510290458u47ad70d2s1f5956cb47c193c0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

An incidental point perhaps, but mounting a read-only file with a
writeable filesystem therein via loopback should probably also fail
with a suitable error (and doesn't right now).

Jon.
