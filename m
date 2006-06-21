Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWFUSuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWFUSuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWFUSuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:50:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:26902 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932340AbWFUSun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:50:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=SUy4Q3NBxyHa3egYXu7q5Q36xlm86jl+A0NzwpX60CjaglqlyCN1egPdfqzYMlhqhaRSu/aPVsal2/Yf30ivqMe3aOLFHkQREykBQxfbhXlMxGkll4/nqaeckX/umWZFAUMrSNfB+3OKmiPHDf+XnL0tqGQqvMbKLG3i8EwA9VE=
Date: Wed, 21 Jun 2006 22:56:15 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG]: 2.6.17-mm1 can not compile - infinite cycle
Message-Id: <20060621225615.7c035069.pauldrynoff@gmail.com>
In-Reply-To: <449993D4.8030309@zytor.com>
References: <20060621224600.aaa03fdc.pauldrynoff@gmail.com>
	<449993D4.8030309@zytor.com>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great. Thanks. Seems all start working.

On Wed, 21 Jun 2006 11:45:40 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> Paul Drynoff wrote:
> > I try compile 2.6.17-mm1 with almost(make oldconfig) the same config as 
> > linux-2.6.17-rc6-mm2.
> 
> I just pushed out this bugfix for this condition.
> 
> 	-hpa
> 
