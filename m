Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVFTUKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVFTUKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVFTUGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:06:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:36593 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261553AbVFTTwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:52:01 -0400
Message-ID: <42B71E41.7080400@austin.ibm.com>
Date: Mon, 20 Jun 2005 14:51:29 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Telemaque Ndizihiwe <telendiz@eircom.net>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaces two GOTO statements with one IF_ELSE statement
 in /fs/open.c
References: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain> <42B70E62.5070704@pobox.com> <Pine.LNX.4.62.0506201154300.2245@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0506201154300.2245@graphe.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

> On Mon, 20 Jun 2005, Jeff Garzik wrote:
> 
> 
>>If you don't like goto, don't read kernel code!
> 
> 
> But his patch also cleans up a code quit a bit.

As a wider question, what is the practice for accepting patches without 
functional changes that simply clean up code and make it look better?

BTW, I also agree that the gotos in this case keep the normal code flow 
cleaner, while making the exceptions isolated well.

