Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWFLJfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWFLJfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWFLJfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:35:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:10804 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751279AbWFLJfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:35:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V6a3mdo7lCX742vA47Kr4QLCSFAo79Bkci+cVKsr/131dPwqWmbgQedwFoF5ZF8E4Bzvf25cbN8TfAH1yKQEPaFVcbzA8bh9cuUTU1cFtZEElEn8gE48UUelgmWfTOeZOsWVeffkuWgh8BmjMa6W2ZHcBMkZ1zmueTfW6M0rE+0=
Message-ID: <b0943d9e0606120235u62110bfcj4e1eeb64eab94a5c@mail.gmail.com>
Date: Mon, 12 Jun 2006 10:35:19 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <1150103864.20886.88.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
	 <1150103864.20886.88.camel@lappy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > I need to do some tests to see how it works but I won't be able to use
> > the radix_tree (as storing each location in the block would lead to a
> > huge tree).
>
> A radix-priority-search-tree would allow to store intervals and query
> addresses.

Great, this would simplify things. I'll post a new version using this
in the next days.

Thanks.

-- 
Catalin
