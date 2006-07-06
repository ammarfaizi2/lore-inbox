Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbWGFKUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbWGFKUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 06:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWGFKUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 06:20:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:48154 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965185AbWGFKUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 06:20:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=tiVMfUXqi2J6I9yC+n9crksWt2s/rWxWQW0XuvgFEr/WetmX4fWU2Gm7Ge89s4yKEbkvzwiqaZRtVwxdUrUqE9G4UEjO4yLc3mK0luXQtEfNwf1iIrWsZf6vSHxFSedDYro/4OBrbX7lqp/r37+kIFO8+NhNyMZbxp24aQbhG/8=
Date: Thu, 6 Jul 2006 14:27:12 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, rhdt@bartol.udel.edu
Subject: Re: linux-2.6.17-mm6: can not boot: bad spinlock magic
Message-Id: <20060706142712.a26f56eb.pauldrynoff@gmail.com>
In-Reply-To: <20060706023131.04de8092.akpm@osdl.org>
References: <20060706130849.f227ae98.pauldrynoff@gmail.com>
	<20060706023131.04de8092.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for patch, it fixes bug for me.

On Thu, 6 Jul 2006 02:31:31 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
