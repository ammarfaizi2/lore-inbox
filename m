Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTE2UAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTE2UAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:00:38 -0400
Received: from holomorphy.com ([66.224.33.161]:650 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262620AbTE2UAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:00:37 -0400
Date: Thu, 29 May 2003 13:13:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Morten Helgesen <morten.helgesen@nextframe.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: list_head debugging patch
Message-ID: <20030529201337.GC8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Morten Helgesen <morten.helgesen@nextframe.net>,
	linux-kernel@vger.kernel.org
References: <20030529130807.GH19818@holomorphy.com> <200305292158.52311.morten.helgesen@nextframe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305292158.52311.morten.helgesen@nextframe.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 09:58:52PM +0200, Morten Helgesen wrote:
> one more ... 
> elem = c3a6464c, elem->prev = c11d59e8, elem->prev->next = c28cc1ec
> ------------[ cut here ]------------
> kernel BUG at include/linux/list.h:39!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c016b21c>]    Not tainted
> EFLAGS: 00010286
> EIP is at file_kill+0x2c/0x150

Same thing; nuke the __list_head_check() check in list_empty() please.


-- wli
