Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752058AbWCOMY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbWCOMY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 07:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbWCOMY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 07:24:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58262 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752058AbWCOMY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 07:24:27 -0500
Subject: Re: PATCH: rio driver rework continued  #1
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1142425052.5597.3.camel@localhost.localdomain>
References: <1142425052.5597.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 13:24:24 +0100
Message-Id: <1142425465.3021.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 12:17 +0000, Alan Cox wrote:
> -typedef volatile u8 BYTE;
> -typedef volatile u16 WORD;
> -typedef volatile u32 DWORD;
> -typedef volatile u16 RIOP;
> +typedef u8 BYTE;
> +typedef u16 WORD;
> +typedef u32 DWORD;


while you're there... might as well kill those ;)

