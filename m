Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265080AbUF1QyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbUF1QyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUF1QyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:54:15 -0400
Received: from mail.scs.ch ([212.254.229.5]:17574 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id S265080AbUF1QyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:54:13 -0400
Subject: Re: [PATCH 4/4] 2.6.7-mm2, Use it in AX.25 drivers
From: Thomas Sailer <sailer@scs.ch>
To: Andrey Panin <pazke@donpac.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <10880815524130@donpac.ru>
References: <10880815524130@donpac.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: SCS
Message-Id: <1088441634.4382.85.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 28 Jun 2004 18:53:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-24 at 14:52, Andrey Panin wrote:
> This patch makes AX.25 drivers use common crc16 code.

Hrm, isn't this bit of a misnamer? 

While the polynomial usually known as "CCITT" or "X25" is
x^16+x^12+x^5+x^0, CRC-16 usually means the polynomial
x^16+x^15+x^2+x^0. So to avoid confusion I suggest renaming it from
CRC16 to CRCCCITT or similar...

Tom

