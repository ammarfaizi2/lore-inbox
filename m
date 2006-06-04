Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932220AbWFDKqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWFDKqz (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 06:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWFDKqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 06:46:55 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:32024 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932220AbWFDKqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 06:46:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TPZ5Qi6RU0tXjjD/OACzrC41RNCbC3QH9pZBI2CIgESaYbE33Sjgn6t1GDTxbXAeV65Zl2OgXNV0E5WQkdeumL8L5rCNsMY2F2qs91QCFDzZz7I2MU+WNbdI4ZZNHnInWm7QsF3kfA2rC+VUU4iI6C4bxlcfa8R/lLqn6vzMcDI=
Message-ID: <986ed62e0606040346v74c7761bpb427cc554aef40d@mail.gmail.com>
Date: Sun, 4 Jun 2006 03:46:53 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: [patch, -rc5-mm3] lock validator: fix ns83820.c irq-flags part 3
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1149415707.3109.96.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060604083017.GA8241@elte.hu>
	 <1149411525.3109.73.camel@laptopd505.fenrus.org>
	 <986ed62e0606040253pfe9c300qf88029f88ae65039@mail.gmail.com>
	 <1149415707.3109.96.camel@laptopd505.fenrus.org>
X-Google-Sender-Auth: 0149ddb2d18147aa
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> ok this is a real driver deadlock:
[snip]

With this third patch added, it boots cleanly, with no lockdep
messages. (And, each time, I've been checking things by sshing into
the box via the ns83820 NIC, so I can also confirm that the card works
with these patches.)
-- 
-Barry K. Nathan <barryn@pobox.com>
