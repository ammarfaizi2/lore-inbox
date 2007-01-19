Return-Path: <linux-kernel-owner+w=401wt.eu-S965068AbXASLmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbXASLmj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 06:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbXASLmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 06:42:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:30135 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965068AbXASLmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 06:42:38 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=td3n2hKVQ6TAStg8Nc8xfuZd+yxb+QcueJa8U4EQW8tYm3YvDLmfwpiZg4CFdY8NjdF81laszpzBIlmmVQmU/maUmT+LebHWUpNqEUdj2+YaH/TLzeWtaV3Jthc8lAUgskPpCG9jvVcaeC8ARHUgCXh5irA0dJBx7cQ0Ra90fIA=
Message-ID: <7783925d0701190342j7e0e89a0ib0e9a7278887355f@mail.gmail.com>
Date: Fri, 19 Jan 2007 17:12:35 +0530
From: "Rick Brown" <rick.brown.3@gmail.com>
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: Re: [DISCUSS] memory allocation method
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <5d96567b0701150536j4c3c50abndec5155ddb53d4a1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5d96567b0701150536j4c3c50abndec5155ddb53d4a1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/07, Raz Ben-Jehuda(caro) <raziebe@gmail.com> wrote:
> I have a process who allocates as much as possible of RAM
> in 4 G ram 32bit machine.  This buffer is never released.
>
> Questions:
>
> 1. Is it better allocates with many 1MB buffers or allocate it in with
> one a big valloc ?

ONe BIG vmalloc has huge, huge chances of failure.
