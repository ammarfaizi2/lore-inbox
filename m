Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264941AbUGHTLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUGHTLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 15:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbUGHTLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 15:11:38 -0400
Received: from mail.scs.ch ([212.254.229.5]:29675 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id S264941AbUGHTLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 15:11:37 -0400
Subject: Re: [PATCH 0/5] 2.6.7-mm6, fix CRC16 misnaming
From: Thomas Sailer <sailer@scs.ch>
To: David Weinehall <tao@acc.umu.se>
Cc: Andrey Panin <pazke@donpac.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040708131007.GC10540@khan.acc.umu.se>
References: <10892916781086@donpac.ru>
	 <20040708131007.GC10540@khan.acc.umu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: SCS
Message-Id: <1089313871.4382.188.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 08 Jul 2004 21:11:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-08 at 15:10, David Weinehall wrote:

> Wouldn't it be better to keep the size here too?
> 
> CRC16-CCITT instead of just CRC-CCITT.

IMO not necessary, the size is clear from the return type, and CCITT
AFAIK never defined a 32bit CRC Poly

Tom

