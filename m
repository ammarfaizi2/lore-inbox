Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264772AbUEEUSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264772AbUEEUSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 16:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264786AbUEEUSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 16:18:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:53663 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264772AbUEEUSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 16:18:33 -0400
Date: Wed, 5 May 2004 13:18:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: eric.valette@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: RE : 2.6.6-rc3-mm2 : REGPARAM forced => no external module with
 some object code only
Message-Id: <20040505131809.10bdcae6.akpm@osdl.org>
In-Reply-To: <4098D65D.9010107@free.fr>
References: <4098D65D.9010107@free.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette <eric.valette@free.fr> wrote:
>
> The Changelog says nothing really important but forcing REGPARAM is 
>  rather important : it breaks any external module using object only code 
>  that calls a kernel function.

This is why we should remove the option - to reduce the number of ways in
which the kernel might have been built.  Yes, there will be a bit of
transition pain while these people catch up.

