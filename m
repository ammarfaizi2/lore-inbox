Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVCaNA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVCaNA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 08:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVCaNA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 08:00:57 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:28086 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261423AbVCaNAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 08:00:45 -0500
Date: Thu, 31 Mar 2005 15:00:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Jeff Garzik <jgarzik@pobox.com>, Yum Rayan <yum.rayan@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce stack usage in time.c
Message-ID: <20050331130017.GA19294@wohnheim.fh-wedel.de>
References: <df35dfeb05033023463a986df4@mail.gmail.com> <424BB443.1070508@pobox.com> <200503311226.58037.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200503311226.58037.vda@ilport.com.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 March 2005 12:26:58 +0300, Denis Vlasenko wrote:
> 
> Is this a syscall?
> Is it ever called from some deeply nested kernel function?

Never showed up in any of my callchain-tests.  I'd leave it as is.

Jörn

-- 
When I am working on a problem I never think about beauty.  I think
only how to solve the problem.  But when I have finished, if the
solution is not beautiful, I know it is wrong.
-- R. Buckminster Fuller
