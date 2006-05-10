Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWEJDOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWEJDOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWEJDOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 23:14:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:58793 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964774AbWEJDOq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 23:14:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=chAZ/uVSoUv7x0ygMZORHme8ANTw/xwOKtuytvT7bG/Qn+LrFk3/sh1X1LA8o1h/i9vzgBvJeA7vQmTtICgFGw8XNkOvkcEVLS8KZDTLhqsuj5dlohL9L6jz/qWjCVMob5/hbOOAzUWDpZAwucNOiWbR+Xi64vfKqaQUXhJmmzM=
Message-ID: <305c16960605092014t240ece2ob620264501deaa39@mail.gmail.com>
Date: Wed, 10 May 2006 00:14:45 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Daniel Walker" <dwalker@mvista.com>
Subject: Re: [BUG] mtd redboot (also gcc 4.1 warning fix)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/06, Daniel Walker <dwalker@mvista.com> wrote:
> unsigned long may not always be 32 bits, right ? This patch fixes the
Incorrect, its defined as 32bits for every standard C compiler
